//
//  UILabel+HTML.swift
//  Dermacycle
//
//  Created by Hernan Paez on 19/2/18.
//

import UIKit

extension UILabel {
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

