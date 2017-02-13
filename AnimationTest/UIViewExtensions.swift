//
//  UIViewExtensions.swift
//  AnimationTest
//
//  Created by Alex Neminsky on 12.02.17.
//  Copyright © 2017 SkaKot. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBlur(type: UIBlurEffectStyle) {
        
        backgroundColor = UIColor.clear
        alpha = 1
        
        let effect =  UIBlurEffect(style: type)
        let effectView = UIVisualEffectView(effect: effect)
        insertSubview(effectView, at: 0)
        effectView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftConstraint = effectView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        let rightConstraint = effectView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
        let topConstraint = NSLayoutConstraint(item: effectView, attribute: .top, relatedBy:.equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: effectView, attribute: .bottom, relatedBy:.equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([leftConstraint, rightConstraint, topConstraint, bottomConstraint])
        
    }
}
