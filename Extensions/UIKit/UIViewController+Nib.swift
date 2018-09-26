//
//  UIViewController+Nib.swift
//  Grapevine
//
//  Created by Hernan Paez on 25/08/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiateFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>(_ viewType: T.Type) -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib(self)
    }
}
