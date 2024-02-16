//
//  LoginViewController.swift
//  AdoptMe
//
//  Created by Quoc Thuan Truong on 12/5/20.
//

import UIKit
import MaterialComponents
import M13Checkbox
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit
import GoogleSignIn
import Firebase
import BCrypt
import SCLAlertView

class LoginViewController: UIViewController {
    @IBOutlet weak var ggLoginButon: UIButton!
    @IBOutlet weak var usernameTextField: MDCOutlinedTextField!
    @IBOutlet weak var passwordTextField: MDCOutlinedTextField!
    @IBOutlet weak var loginManuallyButton: MDCButton!
    @IBOutlet weak var rememberMeCheckBox: M13Checkbox!
    @IBOutlet weak var fbLoginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        
        //GIDSignIn.sharedInstance()?.presentingViewController = self
        //GIDSignIn.sharedInstance()?.delegate = self

    }
    
    func initView() {
        loginManuallyButton.layer.cornerRadius = 12.0
        usernameTextField.layer.cornerRadius = 12.0
        usernameTextField.setOutlineColor(UIColor(named: "AccentColor")!, for: .editing)
        usernameTextField.setOutlineColor(UIColor(named: "AppSecondaryColor")!, for: .normal)
        usernameTextField.leadingView = UIImageView(image: UIImage(named: "ic-blue-username"))
        usernameTextField.leadingViewMode = .always
        usernameTextField.label.text = "Username"
        usernameTextField.setNormalLabelColor(UIColor(named: "AppGrayColor")!, for: .normal)
        usernameTextField.setFloatingLabelColor(UIColor(named: "AccentColor")!, for: .editing)
        usernameTextField.setFloatingLabelColor(UIColor(named: "AppSecondaryColor")!, for: .normal)
        
        passwordTextField.layer.cornerRadius = 12.0
        passwordTextField.backgroundColor = UIColor(named: "TextFeildColor")

        passwordTextField.setOutlineColor(UIColor(named: "AccentColor")!, for: .editing)
        passwordTextField.setOutlineColor(UIColor(named: "AppSecondaryColor")!, for: .normal)
        passwordTextField.leadingView = UIImageView(image: UIImage(named: "ic-blue-password"))
        passwordTextField.leadingViewMode = .always
        passwordTextField.label.text = "Password"
        passwordTextField.setNormalLabelColor(UIColor(named: "AppGrayColor")!, for: .normal)
        passwordTextField.setFloatingLabelColor(UIColor(named: "AccentColor")!, for: .editing)
        passwordTextField.setFloatingLabelColor(UIColor(named: "AppSecondaryColor")!, for: .normal)
    }
    
    func loginManual(){
        
        print("login manual")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dest = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        dest.modalPresentationStyle = .fullScreen
        
        self.present(dest, animated: true, completion: nil)
    }
    
    func loginFirebase()  {
        let currentUser = Auth.auth().currentUser
        
        let userCollection = Firestore.firestore().collection("users")
        
        userCollection.whereField("UID", isEqualTo: currentUser!.uid).limit(to: 1)
            .getDocuments{ (querySnapshot, error) in
                if let error = error {
                    print(error)
                } else {
                    if querySnapshot!.documents.count == 1 {
                        let data = querySnapshot?.documents[0].data()
                        
                        let token = UUID().uuidString
                        
                        Core.shared.setToken(token)
                        userCollection.document(data?["UID"] as! String).updateData(["token": token])
                        Core.shared.setCurrentUserID(data?["UID"] as! String)

                        self.loginManual()
                    } else {
                        let registerVC = self.presentingViewController
                        
                        self.dismiss(animated: true, completion: {
                            let dest = self.storyboard?.instantiateViewController(withIdentifier: "FillInfoViewController") as! FillInfoViewController
                            
                            dest.modalPresentationStyle = .fullScreen
                            
                            dest.userFullName = currentUser?.displayName ?? ""
                            dest.phone = currentUser?.phoneNumber ?? ""
                            
                            print(currentUser)
                            
                            if (dest.phone.count > 0) {
                                if (dest.phone[dest.phone.startIndex] == "0") {
                                    dest.phone.removeFirst()
                                    dest.phone = "+84" + dest.phone
                                }
                            }
                           
                            
                            print(dest.phone)
                            
                            dest.userEmail = currentUser?.email ?? ""
                            dest.UID = currentUser!.uid
                            dest.token = UUID().uuidString
                            
                            Core.shared.setToken(dest.token)
                            Core.shared.setCurrentUserID(dest.UID)
                            	
                            registerVC?.present(dest, animated: true, completion: nil)
                        })
                    }
                }
            }
    }
    
    @IBAction func loginWithFBAct(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                return
            }
            
            guard let result = result, !result.isCancelled else {
                        print("Login cancelled")
                        return
            }

            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    return
                } else {
                    self.loginFirebase()
                }
            })
        }
    }
    
    
    @IBAction func loginManuallyAct(_ sender: Any) {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        let userCollection = Firestore.firestore().collection("users")
        if(username.isEmpty || password.isEmpty){
            let appearance = SCLAlertView.SCLAppearance(
                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                showCloseButton: false, showCircularIcon: false
            )
            
            let alertView = SCLAlertView(appearance: appearance)
            
            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
                alertView.dismiss(animated: true, completion: nil)
            })
            
                
            alertView.showWarning("Warning", subTitle: "empty textfield")
        }else {
            userCollection.whereField("username", isEqualTo: username).limit(to: 1)
                .getDocuments { [self](querySnapshot, error) in
                    if let error = error{
                        print(error)
                    } else {
                        if querySnapshot?.documents.count == 1 {
                            let data = querySnapshot?.documents[0].data()
                            
                            if(BCrypt.Check(password, hashed: data?["password"] as! String)){
                                if(rememberMeCheckBox.checkState == M13Checkbox.CheckState.checked) {
                                    let token = UUID().uuidString
                                    Core.shared.setToken(token)
                                    
                                    userCollection.document(data?["UID"] as! String).updateData(["token": token])
                                }

                                Core.shared.setCurrentUserID(data?["UID"] as! String)
                                Core.shared.setCurrentUserEmail(data?["email"] as! String)
                                Core.shared.setCurrentUserRole(data?["role"] as! String)
                                Core.shared.setCurrentUserFullName(data?["fullname"] as! String)
                                self.loginManual()
                            } else {
                                let appearance = SCLAlertView.SCLAppearance(
                                    kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                                    showCloseButton: false, showCircularIcon: false
                                )
                                
                                let alertView = SCLAlertView(appearance: appearance)
                                
                                alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                                    alertView.dismiss(animated: true, completion: nil)
                                })
                                
                                    
                                alertView.showWarning("Warning", subTitle: "Username or Password is incorrect")
                            }
                        } else {
                            let appearance = SCLAlertView.SCLAppearance(
                                kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
                                showCloseButton: false, showCircularIcon: false
                            )
                            
                            let alertView = SCLAlertView(appearance: appearance)
                            
                            alertView.addButton("CANCEL", backgroundColor: UIColor(named: "AppRedColor"), textColor: .white, showTimeout: .none, action: {
                                alertView.dismiss(animated: true, completion: nil)
                            })
                            
                                
                            alertView.showWarning("Warning", subTitle: "Username or Password is incorrect")
                        }
                    }
                }
        }
    }
    
    @IBAction func forgotPasswordAct(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordViewController") as! ForgotPasswordViewController
        vc.isModalInPresentation = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func registerAct(_ sender: Any) {
        let dest = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
        
        dest.modalPresentationStyle = .fullScreen
        self.present(dest, animated: true, completion: nil)
    }
    
}

