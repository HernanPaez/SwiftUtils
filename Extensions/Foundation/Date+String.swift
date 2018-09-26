//
//  DateExtension.swift
//  BonusApp
//
//  Created by Hernan Paez on 10/7/17.
//  Copyright © 2017 InfinixSoft. All rights reserved.
//

import Foundation


extension String {
    func toDate(withFormat format:String = "dd/MM/yyyy", locale:Locale = Locale(identifier: "en_US_POSIX"), timeZone:TimeZone = TimeZone.current) -> Date? {
        let df = DateFormatter()
        df.dateFormat = format
        df.locale = locale
        df.timeZone = timeZone
        return df.date(from: self)
    }
}

extension Date {
    func toString(withFormat format:String = "dd/MM/yyyy", locale:Locale = Locale(identifier: "en_US_POSIX"), timeZone:TimeZone = TimeZone.current) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        df.locale = locale
        df.timeZone = timeZone

        return df.string(from: self)
    }
}
