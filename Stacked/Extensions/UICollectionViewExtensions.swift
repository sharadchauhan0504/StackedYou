//
//  UICollectionViewExtensions.swift
//  Stacked
//
//  Created by Sharad on 26/09/20.
//

import UIKit

extension UICollectionView {
    
    func registerNib(type: UICollectionViewCell.Type) {
        let identifier = String(describing: type.self)
        let nib        = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: identifier)
    }
}
