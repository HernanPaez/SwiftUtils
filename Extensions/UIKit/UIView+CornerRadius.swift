//
//  UIView+CornerRadius.swift
//  GoTree
//
//  Created by Hernan Paez on 17/05/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import UIKit

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius:CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
}
