//
//  ViewController.swift
//  HolaLove
//
//  Created by Apple on 15/12/2023.
//

import UIKit
import SOTabBar
import Firebase

class ViewController: SOTabBarController {

    var db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initView()
        
    }
    
    func initView() {
        Core.shared.setKeyName("")
        
        let homeVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let favVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MedicalReportViewController") as! MedicalReportViewController
        let addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddPetViewController") as! AddPetViewController
        let chatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        let userVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserViewController") as! UserViewController

        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home-icon"), selectedImage: UIImage(named: "home-selected-icon"))
        favVC.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(named: "home-icon"), selectedImage: UIImage(named: "home-selected-icon"))
        addVC.tabBarItem = UITabBarItem(title: "Add pet", image: UIImage(named: "home-icon"), selectedImage: UIImage(named: "home-selected-icon"))
        chatVC.tabBarItem = UITabBarItem(title: "Chat", image: UIImage(named: "home-icon"), selectedImage: UIImage(named: "home-selected-icon"))
        userVC.tabBarItem = UITabBarItem(title: "User", image: UIImage(named: "home-icon"), selectedImage: UIImage(named: "home-selected-icon"))

        homeVC.isFav = false;
        //favVC.isFav = true;
        
        self.viewControllers = [homeVC, favVC, addVC, chatVC, userVC]
//        self.viewControllers = [homeVC, favVC, addVC, userVC]
    }
    
    override func loadView() {
        super.loadView()
        SOTabBarSetting.tabBarTintColor = .white
        SOTabBarSetting.tabBarHeight = CGFloat(52)
        SOTabBarSetting.tabBarSizeImage = 30
        SOTabBarSetting.tabBarSizeSelectedImage = 33
        SOTabBarSetting.tabBarCircleSize = CGSize(width: 58, height: 40)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }


}

