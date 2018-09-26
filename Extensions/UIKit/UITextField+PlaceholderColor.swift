//
//  UITextField+PlaceholderColor.swift
//  GoTree
//
//  Created by Hernan Paez on 17/05/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import UIKit

@IBDesignable extension UITextField {
    @IBInspectable var placeHolderFontColor:UIColor? {
        set {
            if let color = newValue {
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [.foregroundColor : color])
            }
        }
        get {
            guard let attrStr = self.attributedPlaceholder else { return nil }
            guard attrStr.string.isEmpty == false else { return nil }
            var range = NSRange()
            let obj = attrStr.attribute(.foregroundColor, at: 0, effectiveRange: &range)
            return obj as? UIColor
        }
    }
}

