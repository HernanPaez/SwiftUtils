//
//  Double+extensions.swift
//  Movetivate
//
//  Created by Admin on 6/6/18.
//  Copyright © 2018 Infinixsoft. All rights reserved.
//

import Foundation

extension Double {
    
    func truncate(places : Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
    
    func incomeString() -> String {
        let value = String.localizedStringWithFormat("%d", Int(self))
        return "$\(value)"
    }
    
    func moneyString() -> String {
        
        let value = String
            .localizedStringWithFormat("%.02f", self)
            .replacingOccurrences(of: ",", with: ".")
        
        return "$\(value)"
    }
    
    func metresToMiles() -> Double {
        return self / 1609.344
    }
    
    func milesToMetres() -> Double {
        return self * 1609.344
    }
}

extension Float {
    
    func truncate(places : Int) -> Float {
        return Float(floor(pow(10.0, Float(places)) * self)/pow(10.0, Float(places)))
    }
}
