//
//  LandingPage1VC.swift
//  HolaLove
//
//  Created by Apple on 16/12/2023.
//

import UIKit

class LandingPage1VC: UIViewController {
    var delegate: IntroductionDelegate?
    // MARK: -Outlets
    
    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        nextButton.layer.cornerRadius = 10
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func skipAct(_ sender: Any) {
        delegate?.skipIntroduce()
    }
    
    @IBAction func nextAct(_ sender: Any) {
        delegate?.nextIntroduce()
    }
}
