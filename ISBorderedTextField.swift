//
//  ISBorderedTextField.swift
//  Pezo
//
//  Created by Hernan Paez on 10/10/16.
//  Copyright © 2016 Hernan Paez. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ISBorderedTextField : UITextField {
    
    @IBInspectable var leftMargin:UInt = 0{
        didSet {
            self.configureAppearance()
        }
    }
    
    @IBInspectable var fontColor:UIColor? = nil {
        didSet {
            self.configureAppearance()
        }
    }
    
    @IBInspectable var placeHolderFontColor:UIColor? = nil {
        didSet {
            self.configureAppearance()
        }
    }

    
    func configureAppearance() {
        self.layer.borderColor = borderColor?.cgColor
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        
        if let fontColor = fontColor {
            self.textColor = fontColor
        }
        else {
            self.textColor = borderColor
        }
        
        if let color = placeHolderFontColor {
            self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSForegroundColorAttributeName : color])
        }
        
        if self.leftMargin != 0 {
            self.leftViewMode = .always
            self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: CGFloat(leftMargin), height: self.frame.size.height))
        }
        else {
            self.leftView = nil
        }
    }


}
