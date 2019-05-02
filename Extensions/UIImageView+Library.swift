//
//  UIImageView+Library.swift
//  bar_crawl_nation
//
//  Created by Admin on 2/10/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    
   func setImageFromURL(_ url:String?,placeholder:UIImage? = #imageLiteral(resourceName: "navigation_logo"), completion:(()->Void)? = nil) {
        
        self.kf.cancelDownloadTask()
        
        guard let url = url, url.isEmpty == false, let URL = URL(string: url) else {
            
            self.showPlaceholderOnError(placeholder: placeholder)
            return
        }
         //TODO add placeholder
        
        
        self.kf.setImage(with: URL, placeholder:placeholder, options: nil, progressBlock: nil, completionHandler: {
            (image:Image?, error:NSError?, cache:CacheType, url:URL?) in
            
            completion?()
            
            if error != nil {
                self.showPlaceholderOnError(placeholder: placeholder)
            }
        })
    }
    
    

    fileprivate func showPlaceholderOnError(placeholder:UIImage?) {
       self.image = placeholder
    }
}

