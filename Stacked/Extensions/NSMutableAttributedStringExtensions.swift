//
//  NSMutableAttributedStringExtensions.swift
//  Stacked
//
//  Created by Sharad on 26/09/20.
//

import UIKit

extension NSMutableAttributedString {
   
    @discardableResult func customFont(_ text: String, _ font: UIFont) -> NSMutableAttributedString {
        let attribute = [NSAttributedString.Key.font: font]
        let custom = NSAttributedString(string: text, attributes: attribute)
        append(custom)
        return self
    }
    
}
