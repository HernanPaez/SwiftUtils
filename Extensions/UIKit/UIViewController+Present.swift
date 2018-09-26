//
//  UIViewController+Present.swift
//  Dermacycle
//
//  Created by Hernan Paez on 25/2/18.
//

import UIKit

extension UIViewController {
    static func topViewController() -> UIViewController {
        var vc = (UIApplication.shared.keyWindow?.rootViewController)!
        while vc.presentedViewController != nil {
            vc = vc.presentedViewController!
        }
        return vc
    }
    
    func showModally() {
        let vc = UIViewController.topViewController()
        vc.present(self, animated: true, completion: nil)
    }
    
    @IBAction func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
