//
//  UIView+InfiniteRotation.swift
//  EquineProfile
//
//  Created by Hernan Paez on 14/2/18.
//  Copyright © 2018 Infinixsoft. All rights reserved.
//

import UIKit

extension UIView{
  func rotate() {
    let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
    rotation.toValue = NSNumber(value: Double.pi * 2)
    rotation.duration = 1
    rotation.isCumulative = true
    rotation.repeatCount = Float.greatestFiniteMagnitude
    self.layer.add(rotation, forKey: "rotationAnimation")
  }
}
