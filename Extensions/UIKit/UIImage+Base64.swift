//
//  UIImage+base64.swift
//  caziq
//
//  Created by Admin on 10/8/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

import Foundation
import UIKit

enum C4EncodingError: Error {
    case errorGettingImageData
    case errorGettingEncodeToBase64
}

enum ImageEncodingType {
    case png
    case jpeg(CGFloat) // compression
}

extension UIImage {
    
    // http://stackoverflow.com/questions/11251340/convert-uiimage-to-base64-string-in-objective-c-and-swift
    func asBase64String(encoding: ImageEncodingType) throws -> String {
        
        var imageData: Data?
        var prefix = ""
        
        switch encoding {
            
        case .png:
            guard let _imageData = UIImagePNGRepresentation(self) else {
                throw C4EncodingError.errorGettingImageData
            }
            imageData = _imageData
            prefix = "data:image/png;base64,"
            
        case .jpeg(let compression):
            guard let _imageData = UIImageJPEGRepresentation(self, compression) else {
                throw C4EncodingError.errorGettingImageData
            }
            imageData = _imageData
            prefix = "data:image/jpeg;base64,"
            
        }
        
        guard let data = imageData else {
            throw C4EncodingError.errorGettingImageData
        }
        
        
        let base64String = data.base64EncodedString(options: .lineLength64Characters)
        return prefix + (base64String.replacingOccurrences(of: "\n", with: ""))
    }
    
}

