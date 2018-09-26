//
//  String+HTML.swift
//  Dermacycle
//
//  Created by Hernan Paez on 19/2/18.
//

import Foundation

extension String {
    
    enum HTMLAttribute : String {
        case textAlign = "text-align"
        case color = "color"
        case fontSize = "font-size"
        case fontFamily = "font-family"
    }
    
    func htmlByApplyingAttributes(_ options:[HTMLAttribute:String]) -> String {
        var styleString = ""
        
        if options.isEmpty == false {
            for key in Array(options.keys) {
                let value = options[key]!
                
                switch key {
                case .textAlign, .color, .fontSize:
                    styleString += "\(key.rawValue):\(value); "
                case .fontFamily:
                    styleString += "\(key.rawValue):'\(value)'; "
                }
            }
        }
        else {
            return self
        }
        
        let txt = "<div style=\"\(styleString)\">\(self)</div>"
        return txt
    }
}
