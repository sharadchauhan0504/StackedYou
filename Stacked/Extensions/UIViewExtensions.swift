//
//  UIViewExtensions.swift
//  Stacked
//
//  Created by Sharad on 26/09/20.
//

import UIKit

extension UIView {
    
    func animateAlpha(_ alpha: CGFloat, _ duration: TimeInterval, _ delay: TimeInterval = 0.0, completion: (() -> Void)?) {
        UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: 0.95, initialSpringVelocity: 0.3, options: .curveEaseInOut) {
            self.alpha = alpha
        } completion: { (success) in
            completion?()
        }
    }
    
    func addCornerRadius(radius: CGFloat = 7.0) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat = 8) {
        let maskPath    = UIBezierPath(roundedRect: bounds,
                                     byRoundingCorners: corners,
                                     cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer   = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path  = maskPath.cgPath
        layer.mask      = maskLayer
    }
    
    func addShadow(radius: CGFloat = 8.0, height: CGFloat = 5.0, opacity: Float = 0.3, shadowColor: UIColor = .black) {
        layer.masksToBounds = false
        layer.shadowOffset  = CGSize(width: 0.0, height: height)
        layer.shadowOpacity = opacity
        layer.shadowColor   = shadowColor.cgColor
        layer.shadowRadius  = radius
    }
}
