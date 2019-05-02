//
//  UIView+Shadow.swift
//  bar_crawl_nation
//
//  Created by Admin on 25/9/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func addCircularShadowView(widthOffset:CGFloat=1, heightOffset:CGFloat=1, opacity:Float=0.3, maskToBounds:Bool=false, radius:CGFloat=3.0, color:UIColor = UIColor.black) {
        
        let shadowPath = UIBezierPath(roundedRect: frame, cornerRadius: self.layer.cornerRadius)
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: widthOffset, height: heightOffset)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = maskToBounds
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func addShadowView(widthOffset:CGFloat=1, heightOffset:CGFloat=1, opacity:Float=0.3, maskToBounds:Bool=false, radius:CGFloat=3.0, color:UIColor = UIColor.black){
        
        let shadowPath = UIBezierPath(rect: bounds)
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: widthOffset, height: heightOffset)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = maskToBounds
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    func addshapeShadowView(widthOffset:CGFloat=1, heightOffset:CGFloat=1, opacity:Float=0.3, maskToBounds:Bool=false, radius:CGFloat=4.0, color:UIColor = UIColor.black){
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: widthOffset, height: heightOffset)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = maskToBounds
    }
}

