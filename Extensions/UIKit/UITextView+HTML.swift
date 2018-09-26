//
//  UITextView+HTML.swift
//  Mosaic Golf
//
//  Created by Hernan Paez on 15/06/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func setHTMLFromString(htmlText: String) {
        
        //process collection values
        let attrStr = try! NSAttributedString(
            data: htmlText.data(using: .unicode, allowLossyConversion: true)!,
            options: [.documentType : NSAttributedString.DocumentType.html,
                      .characterEncoding: String.Encoding.utf8.rawValue],
            documentAttributes: nil)
        
        
        self.attributedText = attrStr
    }
}

