//
//  UIImage+Convenience.swift
//  Movetivate
//
//  Created by Admin on 21/5/18.
//  Copyright © 2018 Infinixsoft. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    class func roundedImageFrom(image:UIImage, with size:CGSize,cornerRadius:CGFloat)->UIImage{
        UIGraphicsBeginImageContextWithOptions(size,false,0.0)
        let bounds = CGRect(origin: CGPoint.zero, size: size)
        UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).addClip()
        image.draw(in: bounds)
        let finalImage=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage!
    }
    
    static func takeScreenshot(view: UIView) -> UIImage? {
        
        let scale = UIScreen.main.scale
        let layer = view.layer.presentation()!
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return screenshot
    }
}


