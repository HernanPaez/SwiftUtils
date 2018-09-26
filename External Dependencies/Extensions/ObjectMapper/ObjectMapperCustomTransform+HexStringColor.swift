//
//  ObjectMapperCustomTransform+HexStringColor.swift
//  Biz Incubate
//
//  Created by Steve on 22/05/2018.
//  Copyright © 2018 Steve. All rights reserved.
//

import Foundation
import ObjectMapper

extension ObjectMapperCustomTransform {
  
  class HexStringColor: TransformType {
    public typealias Object = UIColor
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> UIColor? {
      guard let str = value as? String else { return nil }
      return UIColor(hex: str)
    }
    
    open func transformToJSON(_ value: UIColor?) -> String? {
      guard let color = value else { return nil }
      return color.toHexString()
    }
    
  }
  
}
