//
//  HalfRoundedUIView.swift
//  HolaLove
//
//  Created by Apple on 27/12/2023.
//

import UIKit

class HalfRoundedUIView: UIView {
    var halfCornerRadius: CGFloat = 0.0
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
        
    override func layoutSubviews() {
        super.layoutSubviews()
        
        roundCorners(corners: [.topLeft, .topRight], radius: halfCornerRadius)
    }
}
