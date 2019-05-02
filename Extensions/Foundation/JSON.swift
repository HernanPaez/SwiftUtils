//
//  JSON.swift
//  Den
//
//  Created by Hernan Paez on 31/01/2019.
//  Copyright © 2019 InfinixSoft. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
    func toJSONString() -> String {
        let data = try! JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
        return String(data: data, encoding: .utf8)!
    }
}

extension Dictionary where Key == String, Value == Any? {
    func cleanNullKeys() -> Dictionary<String, Any> {
        var d = Dictionary<String, Any>()

        for key in self.keys {
            if let value = self[key] {
                d[key] = value
            }
        }
        
        return d
    }
}


extension String {
    func JSONDictionary() -> [String : Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return object as? [String : Any]
    }
    
    func JSONArray() -> [Any]? {
        guard let data = self.data(using: .utf8) else { return nil }
        let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
        return object as? [Any]
    }
}

