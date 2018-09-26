//
//  NSObject+ClassName.swift
//  GoTree
//
//  Created by Hernan Paez on 30/07/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation

extension NSObject {
    public var thisClassName: String {
        return type(of: self).thisClassName
    }
    
    public static var thisClassName: String {
        return String(describing: self)
    }
}
