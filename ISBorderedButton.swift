//
//  BorderedButton.swift
//  Accord Salud
//
//  Created by Hernan Paez on 13/12/15.
//  Copyright © 2015 Infinixsoft. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class ISBorderedButton: UIButton {
  @IBInspectable var borderColor:UIColor = UIColor.black {
    didSet {
      self.configureAppearance()
    }
  }
  
  @IBInspectable var fontColor:UIColor? = nil {
    didSet {
      self.configureAppearance()
    }
  }
  
  @IBInspectable var borderWidth:CGFloat = 1.0 {
    didSet {
      self.configureAppearance()
    }
  }
  
  @IBInspectable var cornerRadius:CGFloat = 0.0 {
    didSet {
      self.configureAppearance()
    }
  }
  
  func configureAppearance() {
    self.layer.borderColor = borderColor.cgColor
    self.layer.masksToBounds = true
    self.layer.borderWidth = borderWidth
    self.layer.cornerRadius = cornerRadius
    
    if let fontColor = fontColor {
      self.setTitleColor(fontColor, for: .normal)
    }
    else {
      self.setTitleColor(borderColor, for: .normal)
    }
  }
}
