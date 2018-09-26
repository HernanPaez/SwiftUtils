//
//  ObjectMapperCustomTransform+StringInt.swift
//  Biz Incubate
//
//  Created by Steve on 22/05/2018.
//  Copyright © 2018 Steve. All rights reserved.
//

import Foundation
import ObjectMapper

extension ObjectMapperCustomTransform {
  
  class StringInt: TransformType {
    public typealias Object = Int
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Int? {
      guard let intStr = value as? String else { return nil }
      return Int(intStr)
    }
    
    open func transformToJSON(_ value: Int?) -> String? {
      guard let int = value else { return nil }
      return String(int)
    }
    
  }
  
}
