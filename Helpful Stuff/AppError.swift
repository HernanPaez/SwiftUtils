//
//  AppError.swift
//  Mosaic Golf
//
//  Created by Hernan Paez on 13/06/2018.
//  Copyright © 2018 InfinixSoft. All rights reserved.
//

import Foundation
import UIKit

class APPError : Error {
    
    /// An id to the error. Typically a unique UUID is generated. Useful to compare errors and codes
    let id:String
    
    /// Message shown to the user
    let message:String
    
    /// Message visible to the debugger
    var localizedDescription: String {
        return message
    }
    
    
    /// APPError Constructor
    ///
    /// - Parameters:
    ///   - message: A message visible to the user. This value is used by the present() function
    ///   - id: An unique id, by default it will use an unique UUID
    init(message:String, id:String = UUID().uuidString) {
        self.message = message
        self.id = id
    }
}

extension APPError {
    
    /// Default Error (i.e: Unknown Error)
    static let DEFAULT = APPError(message: "Unkown Error", id:"UNKNOWN_ERROR")
    
    /// Error Used to notify the user that his token is invalid and needs to login again
    static let TOKEN_ERROR = APPError(message: "Your user has been logged out.", id:"NOT_AUTHENTICATED")
    
    /// Error used to notify about a cancelled request. This error is not visible to the user
    static let CANCELLED_REQUEST = APPError(message: "The request has been cancelled", id:"REQUEST_CANCELLED")
    
    /// Error used to notify about an empty response from API
    static let EMPTY_RESPONSE = APPError(message: "Empty Response", id:"EMPTY_RESPONSE")
    
    /// Error used to notify about a JSON Decoding error, typically a missing property in json
    static let JSON_DECODE_ERROR = APPError(message: "The response can't be decoded", id:"JSON_DECODE_ERROR")

}

extension APPError : Equatable, Hashable {
    static func == (lhs: APPError, rhs: APPError) -> Bool {
        return lhs.id == rhs.id
    }
    
    var hashValue: Int {
        return id.hashValue
    }
}

extension APPError {
    /// Shows the APPError using an UIAlertController
    ///
    /// - Parameter vc: The view controller to display the error
    func present(controller vc:UIViewController){
        //We Don't show the cancelled error. Tipically this means a API Request was cancelled either by user (by moving to another screen while loading) or app (i.e: cancelled request by a bad token)
        guard self != APPError.CANCELLED_REQUEST else { return }
        
        
        let alert = UIAlertController(title: "Error", message: self.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
    
    /// Presents the APPError to the user using an UIAlertController
    func present() {
        
        let vc = UIViewController.topViewController()
        self.present(controller: vc)
    }
}
