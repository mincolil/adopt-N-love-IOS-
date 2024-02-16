//
//  ConfirmMedicalViewController.swift
//  HolaLove
//
//  Created by Apple on 06/01/2024.
//

import Foundation
import UIKit
import NearbyInteraction
import MultipeerConnectivity

class ConfirmMedicalViewCOntroller : UIViewController {
    
    let circleLayer = CAShapeLayer()
    let animationGroup = CAAnimationGroup()
    
    override func viewDidLoad() {
            super.viewDidLoad()
            drawSonor()
            
        }
    func drawSonor() {
        let path = UIBezierPath(arcCenter: CGPoint(x: view.bounds.width / 2, y: 0),
                                radius: 100,
                                startAngle: 0,
                                endAngle: .pi * 2.0,
                                clockwise: true
        )
        
        let endPath =  UIBezierPath(arcCenter: CGPoint(x: view.bounds.width / 2, y: 0),
                                    radius: view.bounds.height,
                                    startAngle: 0,
                                    endAngle: .pi * 2.0,
                                    clockwise: true
        )
        
        circleLayer.fillColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1).cgColor
        circleLayer.path = path.cgPath
        
        view.layer.addSublayer(circleLayer)
        
        // Animate the Path
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = path.cgPath
        pathAnimation.toValue = endPath.cgPath
        
        // Animate the alpha value
        let alphaAnimation = CABasicAnimation(keyPath: "alpha")
        alphaAnimation.fromValue = 0.8
        alphaAnimation.toValue = 0
        
        // Run Path and Alpha animation simultaneously
        animationGroup.beginTime = 0
        animationGroup.animations = [pathAnimation, alphaAnimation]
        animationGroup.duration = 1.88
        animationGroup.repeatCount = 1
        animationGroup.isRemovedOnCompletion = false
        animationGroup.fillMode = CAMediaTimingFillMode.forwards

        // Add the animation to the layer.
        circleLayer.add(animationGroup, forKey: "sonar")
    }
}
