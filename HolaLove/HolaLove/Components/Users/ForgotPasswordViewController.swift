//
//  ForgotPasswordViewController.swift
//  AdoptMe
//
//  Created by Quoc Thuan Truong on 1/1/21.
//

import UIKit
import MaterialComponents
import FlagPhoneNumber
import MessageUI
import FirebaseAuth
import FirebaseCore

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var sendButton: MDCButton!
    @IBOutlet weak var phoneTextField: FPNTextField!
    @IBOutlet weak var dummyPhoneTextField: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var RecoverView: HalfRoundedUIView!
    
    
    static let path = Bundle.main.path(forResource: "Config", ofType: "plist")
    static let config = NSDictionary(contentsOfFile: path!)
    private static let baseURLString = config!["serverURL"] as! String
    
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
    
    var countryCode = ""
    var phoneNumber = ""
    var isValidPhoneNumber = true

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    
    func initView() {
        RecoverView.layer.borderColor = UIColor(named: "AppGayColor")?.cgColor
        sendButton.layer.cornerRadius = 15.0
        
        phoneTextField.layer.borderWidth = 0
        phoneTextField.layer.borderColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.0).cgColor
        phoneTextField.layer.cornerRadius = 5.0

        dummyPhoneTextField.layer.borderWidth = 1
        dummyPhoneTextField.layer.cornerRadius = 5.0
        dummyPhoneTextField.layer.borderColor = UIColor(named: "AppSecondaryColor")?.cgColor

        backButton.layer.borderWidth = 1
        backButton.layer.cornerRadius = 15.0
        backButton.layer.borderColor = UIColor(named: "Button Color")?.cgColor

        //setup send OTP code to user's phone (only VN)
        phoneTextField.setFlag(key: .VN)
        countryCode = "+84"
        phoneTextField.delegate = self

        phoneTextField.displayMode = .list // .picker by default

        listController.setup(repository: phoneTextField.countryRepository)
        listController.didSelect = { [weak self] country  in
            self?.phoneTextField.setFlag(countryCode: country.code)
        }
    }

    @IBAction func beginEnterPhoneAct(_ sender: Any) {
        dummyPhoneTextField.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
    }

    // Function send Act

    
    @IBAction func sendAct(_ sender: Any) {
        let current = self.presentingViewController
        
        //---
        print( " phone ", self.phoneNumber)
        
        if !self.phoneNumber.isEmpty{
            //for testing
            Auth.auth().settings?.isAppVerificationDisabledForTesting = true
            //---
            PhoneAuthProvider.provider().verifyPhoneNumber(self.phoneNumber, uiDelegate: nil){ verificationID, error in
                if error != nil {
                    print(error)
                    return
                } else {
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                    self.dismiss(animated: true) {
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VerifyAccountViewController") as! VerifyAccountViewController
                        vc.countryCode = self.countryCode
                        vc.phoneNumber = self.phoneNumber
                        current?.present(vc, animated: true)
                    }
                }
            }
            
            
            
        }
        
        
    }
    
    
    // back action in forgot password screen
    @IBAction func backAct(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ForgotPasswordViewController: FPNTextFieldDelegate {


   func fpnDisplayCountryList() {
    let navigationViewController = UINavigationController(rootViewController: listController)

      listController.title = "Countries"

      self.present(navigationViewController, animated: true, completion: nil)
   }


   func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
    print(name, dialCode, code) // Output "France", "+33", "FR"
    countryCode = dialCode
}


   func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
      if isValid {
        phoneNumber = countryCode + textField.getRawPhoneNumber()!       // Output "600000001"
        isValidPhoneNumber = true
      } else {
            isValidPhoneNumber = false
      }
   }
}
