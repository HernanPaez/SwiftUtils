//
//  UIFont+App.swift
//  Pezo
//
//  Created by Hernan Paez on 10/12/16.
//  Copyright © 2016 Hernan Paez. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func appFontWithSize(size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Regular", size: size)!
    }
    
    static func appFontLightWithSize(size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Light", size: size)!
    }

    static func appFontBoldWithSize(size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Bold", size: size)!
    }

    static func appFontBlackWithSize(size:CGFloat) -> UIFont {
        return UIFont(name: "Montserrat-Black", size: size)!
    }

}
