//
//  VerifyAccountViewController.swift
//  HolaLove
//
//  Created by Apple on 15/12/2023.
//

import UIKit
import OTPFieldView
import MaterialComponents
import FirebaseAuth
import FirebaseCore

class VerifyAccountViewController: UIViewController {
    
    @IBOutlet weak var verifyButton: MDCButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    
    var countryCode = ""
    var phoneNumber = ""
    var otpCode: String?

    @IBOutlet weak var otpTextFieldView: OTPFieldView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 1
        self.otpTextFieldView.defaultBorderColor = UIColor(named: "AppSecondaryColor")!
        self.otpTextFieldView.filledBorderColor = UIColor(named: "AccentColor")!
        self.otpTextFieldView.cursorColor = UIColor(named: "ButtonColor")!
        self.otpTextFieldView.displayType = .roundedCorner
        self.otpTextFieldView.fieldSize = 50
        self.otpTextFieldView.backgroundColor = UIColor(named: "AppGrayColor")
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = false
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
        
        verifyButton.layer.cornerRadius  = 5.0
        
        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 5.0
        backButton.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
    }
    

    @IBAction func resendAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func backAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        
        self.present(vc, animated: false, completion: nil)
        
    }
    
    @IBAction func verifyAct(_ sender: Any) {
        print("enter")
        if let authVerificationID = UserDefaults.standard.string(forKey: "authVerificationID"), let code = otpCode{
            let credential = PhoneAuthProvider.provider().credential(withVerificationID: authVerificationID, verificationCode: code)
            Auth.auth().signIn(with: credential) { authData, error in
                if error != nil {
                    return
                }else {
                    print("succed!!")
                }
            }
        }
    }
    
}

extension VerifyAccountViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
        
    func enteredOTP(otp otpString: String) {
        otpCode = otpString
        print("OTPString: \(otpCode!)")
    }
}
