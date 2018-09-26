//
//  ISHighlightTextField.swift
//
//  Created by Hernan Paez on 18/5/16.
//  Copyright © 2016 InfinixSoft. All rights reserved.
//

import UIKit

@IBDesignable class HighlightTextField: UITextField {

    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    @IBInspectable var defaultColor:UIColor = UIColor(red: 234.0/255.0, green: 234.0/255.0, blue: 234.0/255.0, alpha: 1)
    @IBInspectable var highlightedColor:UIColor = UIColor(red: 1.000, green: 0.000, blue: 0.000, alpha: 1.000)
    @IBInspectable var lineHeight:CGFloat = 2

    fileprivate var color:UIColor?
    
    @IBInspectable var leftPadding: CGFloat = 0.0 {
        didSet {
            _leftView?.frame = CGRect(x: 0.0, y: 0.0, width: leftPadding, height: self.frame.height)
        }
    }
    private var _leftView: UIView? = UIView(frame: CGRect.zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.leftView = _leftView
        self.leftViewMode = UITextFieldViewMode.always
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code

        //// Rectangle Drawing
        let rectanglePath = UIBezierPath(rect: CGRect(x: 0, y: self.frame.size.height - lineHeight, width: self.frame.size.width, height: lineHeight))
        (color ?? defaultColor).setFill()
        rectanglePath.fill()
    }
    
    override func becomeFirstResponder() -> Bool {
        color = highlightedColor
        self.setNeedsDisplay()
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        color = defaultColor
        self.setNeedsDisplay()
        
        return super.resignFirstResponder()
    }

}
