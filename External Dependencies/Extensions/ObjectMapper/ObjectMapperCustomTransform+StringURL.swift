//
//  ObjectMapperCustomTransform+StringURL.swift
//  Biz Incubate
//
//  Created by Steve on 22/05/2018.
//  Copyright © 2018 Steve. All rights reserved.
//

import Foundation
import ObjectMapper

extension ObjectMapperCustomTransform {
  
  class StringURL: TransformType {
    public typealias Object = URL
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> URL? {
      guard let str = value as? String else { return nil }
      return URL(string: str)
    }
    
    open func transformToJSON(_ value: URL?) -> String? {
      guard let url = value else { return nil }
      return url.absoluteString
    }
    
  }
  
}
