//
//  String+ToURL.swift
//  GoTree
//
//  Created by Hernan Paez on 30/07/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation

extension String {
    func toURL() -> URL? {
        return URL(string: self)
    }
}
