//
//  HighlightTextView.swift
//  GoTree
//
//  Created by Hernan Paez on 29/05/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import UIKit

@IBDesignable class HighlightTextView : UITextView {
    
    @IBInspectable var defaultColor:UIColor = UIColor(red: 212.0/255.0,
                                                      green: 212.0/255.0,
                                                      blue: 212.0/255.0,
                                                      alpha: 1) {
        didSet {
            self.setNeedsDisplay()
            self.layer.displayIfNeeded()
        }
    }
    
    @IBInspectable var highlightedColor:UIColor = UIColor(red: 1.000,
                                                          green: 0.000,
                                                          blue: 0.000,
                                                          alpha: 1.000) {
        didSet {
            self.setNeedsDisplay()
            self.layer.displayIfNeeded()
        }
    }
    
    @IBInspectable var lineHeight:CGFloat = 2

    fileprivate var color:UIColor?
    
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
