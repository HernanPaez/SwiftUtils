//
//  UIImage+merge_image.swift
//  bar_crawl_nation
//
//  Created by Admin on 17/10/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func combineWith(image: UIImage) -> UIImage {
        
        let size = CGSize(width: self.size.width, height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        self.draw(in: CGRect(x:0 , y: 0, width: size.width, height: size.height))
        image.draw(in: CGRect(x: 0, y: 0, width: size.width,  height: size.height))
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
