//
//  BorderedButton.swift
//
//  Created by Hernan Paez on 13/12/15.
//  Copyright © 2015 Infinixsoft. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class BorderedButton: UIButton {
  @IBInspectable var borderColor:UIColor = UIColor.black {
    didSet {
      self.configureAppearance()
    }
  }
    
  @IBInspectable var borderWidth:CGFloat = 1.0 {
    didSet {
      self.configureAppearance()
    }
  }
    
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            self.configureAppearance()
        }
    }
    
  func configureAppearance() {
    self.layer.borderColor = borderColor.cgColor
    self.layer.masksToBounds = true
    self.layer.borderWidth = borderWidth
    self.layer.cornerRadius = cornerRadius
  }
}
