//
//  UIViewExtension.swift
//  Stacked
//
//  Created by Sharad on 26/09/20.
//

import UIKit

extension UIView {
    
    func expandAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.subviews.forEach { $0.alpha = 1.0 }
            self.alpha     = 1.0
            self.transform = .identity
        }, completion: nil)
    }
    
    func collapseAnimation(_ yOffset: CGFloat) {
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.95, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: {
            self.subviews.forEach { $0.alpha = 0.0 }
            self.alpha     = 0.0
            self.transform = CGAffineTransform(translationX: 0.0, y: yOffset)
        }, completion: nil)
    }
}

