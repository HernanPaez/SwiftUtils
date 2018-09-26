//
//  ObjectMapperCustomTransform+StringDate.swift
//  Biz Incubate
//
//  Created by Steve on 22/05/2018.
//  Copyright © 2018 Steve. All rights reserved.
//

import Foundation
import ObjectMapper

extension ObjectMapperCustomTransform {
  
  final class StringDate: TransformType {
    
    private static var dateFormatter: DateFormatter = {
      let df = DateFormatter()
      df.locale = Locale(identifier: "en_us_POSIX")
      df.timeZone = TimeZone(abbreviation: "UTC")
      df.dateFormat = "yyyy-MM-dd'T' HH:mm:ss"
      return df
    }()
    
    public typealias Object = Date
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Date? {
      guard let timeStr = value as? String else { return nil }
      return ObjectMapperCustomTransform.StringDate.dateFormatter.date(from: timeStr)
    }
    
    open func transformToJSON(_ value: Date?) -> String? {
      guard let date = value else { return nil }
      return ObjectMapperCustomTransform.StringDate.dateFormatter.string(from: date)
    }
    
  }
  
}
