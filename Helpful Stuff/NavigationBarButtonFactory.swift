//
//  NavigationBarButtonFactory.swift
//  Grapevine
//
//  Created by Admin on 11/9/18.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation
import UIKit


class NavigationBarButtonFactory {
    
    
    static func buildHamburgerButton(target:Any?,selector:Selector) -> UIBarButtonItem {
        return self.buildButton(image: #imageLiteral(resourceName: "ic_hamburger_button"), target: target, selector: selector)
    }
    static func buildPinButton(target:Any?,selector:Selector) -> UIBarButtonItem {
         return self.buildButton(image: #imageLiteral(resourceName: "ic_pin"), target: target, selector: selector)
    }
    static func buildSearchButton(target:Any?,selector:Selector) -> UIBarButtonItem {
        
        return self.buildButton(image: #imageLiteral(resourceName: "ic_search"), target: target, selector: selector)
    }
    
    
    private static func buildButton(image:UIImage,color:UIColor = .white,target:Any?,selector:Selector) -> UIBarButtonItem {
        
        let image:UIImage = image.withRenderingMode(.alwaysTemplate)
        
        let button = UIBarButtonItem(image:image, style: .plain, target: target, action: selector)
        button.tintColor = color
        
        return button
    }
}
