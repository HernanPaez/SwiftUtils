//
//  String+Validation.swift
//  Udely
//
//  Created by Hernan Paez on 22/11/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

import Foundation

extension String {
  var isValidEmail:Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: self)
  }
  
  var trimmingWhitespaces:String {
    return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
  }
}
