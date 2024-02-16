//
//  RegisterViewController.swift
//  HolaLove
//
//  Created by Apple on 15/12/2023.
//

import UIKit
import MaterialComponents
import FlagPhoneNumber
import SCLAlertView
import ProgressHUD

class RegisterViewController : UIViewController {
    
    @IBOutlet weak var phoneTextField: FPNTextField!
    @IBOutlet weak var usernameTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var retypePasswordTextField: MDCOutlinedTextField!
    @IBOutlet weak var registerButton: MDCButton!
    @IBOutlet weak var dummyPhoneTextField: MDCOutlinedTextField!
    @IBOutlet weak var doctorRegisterButton: MDCButton!
    
    let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped);
    var phoneNumber = ""
    var isCorrect = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func initView(){
        let textFields: [MDCOutlinedTextField] = [usernameTextField, passwordTextField, retypePasswordTextField]
        let leadingIconNames: [String] = [ "ic-blue-username", "ic-blue-password", "ic-blue-password"]
        let labelForTFs: [String] = ["Username", "Password", "Retype password"]
        
        registerButton.layer.cornerRadius = 12.0
        
        doctorRegisterButton.layer.borderWidth = 1.2
        doctorRegisterButton.layer.cornerRadius = 12.0
        doctorRegisterButton.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
        
        for i in 0..<textFields.count {
            textFields[i].setOutlineColor(UIColor(named: "AccentColor")!, for: .editing)
            textFields[i].setOutlineColor(UIColor(named: "AppSecondaryColor")!, for: .normal)
            textFields[i].leadingView = UIImageView(image: UIImage(named: leadingIconNames[i]))
            textFields[i].leadingViewMode = .always
            textFields[i].label.text = labelForTFs[i]
            textFields[i].setNormalLabelColor(UIColor(named: "AppGrayColor")!, for: .normal)
            textFields[i].setFloatingLabelColor(UIColor(named: "AccentColor")!, for: .editing)
            textFields[i].setFloatingLabelColor(UIColor(named: "AppSecondaryColor")!, for: .normal)
        }
        
        dummyPhoneTextField.layer.cornerRadius = 12.0
        dummyPhoneTextField.setOutlineColor(UIColor(named: "AccentColor")!, for: .editing)
        dummyPhoneTextField.setOutlineColor(UIColor(named: "AppSecondaryColor")!, for: .normal)
        dummyPhoneTextField.label.text = "Phone"
        dummyPhoneTextField.setNormalLabelColor(UIColor(named: "AppGrayColor")!, for: .normal)
        dummyPhoneTextField.setFloatingLabelColor(UIColor(named: "AccentColor")!, for: .editing)
        dummyPhoneTextField.setFloatingLabelColor(UIColor(named: "AppSecondaryColor")!, for: .normal)

        phoneTextField.delegate = self
        
        phoneTextField.layer.borderWidth = 0
        phoneTextField.layer.borderColor = UIColor(named: "AccentColor")?.withAlphaComponent(0.0).cgColor
        phoneTextField.layer.cornerRadius = 12.0
        
        phoneTextField.setFlag(key: .VN)
        phoneTextField.delegate = self
        
        phoneTextField.displayMode = .list // .picker by default

        listController.setup(repository: phoneTextField.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.phoneTextField.setFlag(countryCode: country.code)
            
        }
            
        usernameTextField.layer.cornerRadius = 12.0
        passwordTextField.layer.cornerRadius = 12.0
        retypePasswordTextField.layer.cornerRadius = 12.0
    }
    
    @IBAction func dummyPhoneBeginEdit(_ sender: Any) {
        dummyPhoneTextField.text = " "
        dummyPhoneTextField.setOutlineColor(UIColor(named: "AccentColor")!, for: .normal)
        dummyPhoneTextField.setFloatingLabelColor(UIColor(named: "AccentColor")!, for: .normal)
    }
    
    @IBAction func dummyPhoneEditEnd(_ sender: Any) {
        if phoneTextField.text! == "" {
            dummyPhoneTextField.text = ""
            dummyPhoneTextField.setOutlineColor(UIColor(named: "AppSecondaryColor")!, for: .normal)

            dummyPhoneTextField.setNormalLabelColor(UIColor(named: "AppGrayColor")!, for: .normal)
            dummyPhoneTextField.setFloatingLabelColor(UIColor(named: "AppSecondaryColor")!, for: .normal)
        }
    }
    
    @IBAction func registerAct(_ sender: Any) {
        checkCorrectForm()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) { [self] in
            if (self.isCorrect) {
                let phone = self.phoneTextField.getFormattedPhoneNumber(format: .E164)!
                let username = self.usernameTextField.text!
                let password = self.passwordTextField.text!
                
                
                let dest = self.storyboard?.instantiateViewController(withIdentifier: "FillInfoViewController") as! FillInfoViewController
                
                dest.modalPresentationStyle = .fullScreen
                
                dest.username = username
                dest.password = password
                dest.phone = phone
                dest.role = "User"
                
                self.present(dest, animated: true, completion: nil)
               
            }
        }
    }
    
    @IBAction func RegisterAsDoctorAct(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) { [self] in
            if (self.isCorrect) {
                let phone = self.phoneTextField.getFormattedPhoneNumber(format: .E164)!
                let username = self.usernameTextField.text!
                let password = self.passwordTextField.text!
                
                
                let dest = self.storyboard?.instantiateViewController(withIdentifier: "FillInfoViewController") as! FillInfoViewController
                
                dest.modalPresentationStyle = .fullScreen
                
                dest.username = username
                dest.password = password
                dest.phone = phone
                dest.role = "Doctor"
                
                self.present(dest, animated: true, completion: nil)
               
            }
        }
    }
    
    
    @IBAction func LoginAct(_ sender: Any) {
        
        
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

        dest.modalPresentationStyle = .fullScreen
        self.present(dest, animated: true, completion: nil)

        
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    func isSame(_ password: String, _ retype: String) -> Bool {
        return password == retype
    }
    
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
     
        // at least one uppercase,
        // at least one digit
        // at least one lowercase
        // 8 characters total
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        return passwordTest.evaluate(with: testStr)
    }
    
    func checkCorrectForm() {
        var result = false
        var alertMessage = ""
        
        if (phoneTextField.text! == "") {
            alertMessage = "Phone must be filled"
            
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: alertMessage)
            
            return;
        }
        
        if (usernameTextField.text! == "") {
            alertMessage = "Username must be filled"
            
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: alertMessage)
            
            return;
        }
        
        if (passwordTextField.text! == "") {
            alertMessage = "Password must be filled"
            
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: alertMessage)
            
            return
        }
        
        if (retypePasswordTextField.text! == "") {
            alertMessage = "Retype password must be filled"
            
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
            alertView.showWarning("Warning", subTitle: alertMessage)
            
            return;
        }
    
        ProgressHUD.animate("activityIndicator")
        db.collection("users").whereField("username", isEqualTo: self.usernameTextField.text!)
            .getDocuments{ (querySnapshot, error) in
                if let error = error {
                    print(error)
                } else {
                    if querySnapshot!.documents.count >= 1 {
                        alertMessage = "username already exists"
                        
                        let appearance = SCLAlertView.SCLAppearance(
                            kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                            showCloseButton: false, showCircularIcon: false
                        )
                        
                        let alertView = SCLAlertView(appearance: appearance)
                        
                        alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                            alertView.dismiss(animated: true, completion: nil)
                        })
                        
                        alertView.showWarning("Warning", subTitle: alertMessage)
                        
                        result = false;
                        
                    } else {
                        db.collection("users").whereField("phone", isEqualTo: self.phoneNumber)
                            .getDocuments{ (querySnapshot, error) in
                                if let error = error {
                                    print(error)

                                } else {
                               
                                    if querySnapshot!.documents.count >= 1 {
                                        alertMessage = "phone number already exists"
                                        
                                        let appearance = SCLAlertView.SCLAppearance(
                                            kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                                            showCloseButton: false, showCircularIcon: false
                                        )
                                        
                                        let alertView = SCLAlertView(appearance: appearance)
                                        
                                        alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                                            alertView.dismiss(animated: true, completion: nil)
                                        })
                                        
                                        alertView.showWarning("Warning", subTitle: alertMessage)
                                        result = false

                                    } else {
                                        print("1")
                                        if (!self.isValidPassword(testStr: self.passwordTextField.text!)) {
                                            //alert mat khau yeu
                                            print("2")
                                            alertMessage = "Weak password. Password must include at least one uppercase, one lowercase, one digit and 8 characters total "
                                            
                                            let appearance = SCLAlertView.SCLAppearance(
                                                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                                                showCloseButton: false, showCircularIcon: false
                                            )
                                            
                                            let alertView = SCLAlertView(appearance: appearance)
                                            
                                            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                                                alertView.dismiss(animated: true, completion: nil)
                                            })
                                            
                                            alertView.showWarning("Warning", subTitle: alertMessage)
                                            
                                            result = false

                                        } else {
                                            print("3")
                                            if (!self.isSame(self.passwordTextField.text!, self.retypePasswordTextField.text!)) {
                                                print("4")
                                                alertMessage = "password and retype must be same"
                                                
                                                let appearance = SCLAlertView.SCLAppearance(
                                                    kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                                                    showCloseButton: false, showCircularIcon: false
                                                )
                                                
                                                let alertView = SCLAlertView(appearance: appearance)
                                                
                                                alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                                                    alertView.dismiss(animated: true, completion: nil)
                                                })
                                                
                                                alertView.showWarning("Warning", subTitle: alertMessage)
                                                
                                                result = false
                       
                                            } else {
                                                result = true

                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
        }
    
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute :  {
            ProgressHUD.dismiss()
            self.isCorrect = result;
        })
        
    
    }
    
    
    @IBAction func test(_ sender: Any) {
        print("databese :")
        print(db)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dest = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        dest.modalPresentationStyle  = .fullScreen
        self.present(dest, animated: true, completion: nil)
    }
    
    
}





extension RegisterViewController: FPNTextFieldDelegate {
    func fpnDisplayCountryList() {
        let navigationViewController = UINavigationController(rootViewController:  listController)
        
        listController.title = "Contries"
        
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        print(name, dialCode, code)
    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        if isValid {
          phoneNumber = textField.getFormattedPhoneNumber(format: .E164)!       // Output "600000001"
          print(phoneNumber)
          
      
        } else {
             
        }
    }
}
