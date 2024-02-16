//
//  WelcomeVC.swift
//  HolaLove
//
//  Created by Apple on 16/12/2023.
//

import UIKit
import MaterialComponents
import QuartzCore

class WelcomeVC: UIViewController {
    // MARK: -Outlets
    @IBOutlet weak var registerButton: MDCButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.layer.cornerRadius = 12.0
        loginButton.layer.cornerRadius = 12.0
        loginButton.layer.borderWidth = 1.5
        loginButton.layer.borderColor = UIColor(named: "ButtonColor")?.cgColor
    }
    
    @IBAction func registerAct(_ sender: Any) {
        print("registerbutton click")
        let welcomeVC = self.presentingViewController

        self.dismiss(animated: true, completion: {
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            let dest = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController

            dest.modalPresentationStyle = .fullScreen
            //Show register screen
            welcomeVC?.present(dest, animated: true, completion: nil)
        })
    }
    

    @IBAction func loginAct(_ sender: Any) {
        let welcomeVC = self.presentingViewController

        self.dismiss(animated: true, completion: {
            let storyboard = UIStoryboard(name: "Auth", bundle: nil)
            let dest = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

            dest.modalPresentationStyle = .fullScreen
            //Show login screen
            welcomeVC?.present(dest, animated: true, completion: nil)
        })
    }
    
}
