//
//  HUD.swift
//  Udely
//
//  Created by Hernan Paez on 8/11/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

import Foundation
import SVProgressHUD

class HUD {
    init() {
        fatalError("This class shouldn't be instantiated")
    }
    
    static func configureHUD() {
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setMinimumDismissTimeInterval(2)
    }
    
    static func show() {
        configureHUD()
        SVProgressHUD.show()
    }
    
    static func show(_ text:String) {
        configureHUD()
        SVProgressHUD.show(withStatus: text)
    }
    
    static func dismiss() {
        SVProgressHUD.dismiss()
    }
    
}
