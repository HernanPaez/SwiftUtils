//
//  UIFont+App.swift
//
//  Created by Hernan Paez on 10/12/16.
//  Copyright © 2016 Hernan Paez. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    static func debugFonts() {
        print("| ==============================")
        print("| Font Families:")
        print("| ------------------------------")
        print("| \t- " + UIFont.familyNames.joined(separator: "\n| \t- "))
        print("| ==============================")
        print("| Available Fonts:")
        for familyName in UIFont.familyNames {
            print("| ------------------------------")
            print("| Family Name: \(familyName)")
            print("| Font Names:")
            for name in UIFont.fontNames(forFamilyName: familyName) {
                print("| \t\t\(name)")
            }
        }
        print("| ------------------------------")
    }
    
    static func appFontWithSize(size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
    
    static func appFontLightWithSize(size:CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    static func appFontBoldWithSize(size:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }

    static func appFontBlackWithSize(size:CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }

}
