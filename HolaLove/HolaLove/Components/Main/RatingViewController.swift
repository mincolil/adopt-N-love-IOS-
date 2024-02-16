//
//  RatingViewCOntroller.swift
//  HolaLove
//
//  Created by Apple on 07/01/2024.
//

import Foundation
import UIKit
import SCLAlertView


class RatingViewController : UIViewController {
    
    
    
    
    //test cung'
    let doc_id = "ADBDA588-FCEC-4C6F-8045-C43FCF05564F"
    let mr_id = "B7258990-80D9-4117-8859-29B353C6D0BA"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = SCLAlertView.SCLAppearance(
            kButtonFont: UIFont(name: "HelveticaNeue", size: 17)!,
            showCloseButton: false, showCircularIcon: false
        )

        let alertView = SCLAlertView(appearance: appearance)

        alertView.addButton("CONFIRM", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, target: self, selector: #selector(addUpvote))

        alertView.addButton("CANCEL", backgroundColor: UIColor(named: "ButtonColor"), textColor: .white, showTimeout: .none, action: {
            alertView.dismiss(animated: true, completion: nil)
        })


        alertView.showWarning("Warning", subTitle: "How do you feel about this ...?")
    }
    
    @objc func addUpvote() {
        
    }

    @IBAction func yesAct(_ sender: Any) {
        var newRate = DoctorRate()
        newRate.rate_id = UUID().uuidString
        
        db.collection("doctorRates").document(newRate.rate_id).setData([
            "rate_id": newRate.rate_id,
            "doctor_id": self.doc_id,
//                            "avatar" : newMR.avatar,
            "user_id" : Core.shared.getCurrentUserID(),
            "mr_id" : self.mr_id,
            "comment" : "test comment",
            "tyoe" : "upvote",
            "posted-date" : Date()
        ], merge: true)
    }
    
    
}
