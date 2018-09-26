//
//  ISBorderedTextField.swift
//
//  Created by Hernan Paez on 10/10/16.
//  Copyright © 2016 Hernan Paez. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BorderedTextField : UITextField {
    @IBInspectable var borderColor:UIColor? = nil {
        didSet {
            configureAppearance()
        }
    }
    @IBInspectable var borderWidth:CGFloat = 0.0 {
        didSet {
            self.configureAppearance()
        }
    }

    @IBInspectable var leftMargin:UInt = 0{
        didSet {
            self.configureAppearance()
        }
    }
        
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            self.configureAppearance()
        }
    }
    
    func configureAppearance() {
        self.layer.borderColor = borderColor?.cgColor
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
                        
        if self.leftMargin != 0 {
            self.leftViewMode = .always
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(leftMargin), height: self.frame.size.height))
        }
        else {
            self.leftView = nil
        }
    }


}
