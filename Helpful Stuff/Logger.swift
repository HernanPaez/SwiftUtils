//
//  Logger.swift
//  Udely
//
//  Created by Hernan Paez on 7/11/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

import Foundation
import Fabric
import Crashlytics

class Logger {
    enum Priority : String {
        case verbose = "verbose"
        case warning = "Warning!"
        case error = "ERROR"
    }
    
    private static var dateFormatter:DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return df
    }()
    
    static func log(_ message:String) {
        log(message: message)
    }
    
    static func start() {
        //Fabric
        Fabric.with([Crashlytics.self])
        
//        //Hockey App
//        BITHockeyManager.shared().configure(withIdentifier: "44abbd079c254eb9a7988ae792932dc0")
//        BITHockeyManager.shared().start()
//        BITHockeyManager.shared().authenticator.authenticateInstallation()
    }
    
    static func log(message:String, tag:String? = nil, priority:Logger.Priority = .verbose) {
        #if DEBUG
        let timestamp = dateFormatter.string(from: Date())
        var fullMessage = "[\(timestamp)] || [\(priority.rawValue)]"
        
        if let tag = tag {
            fullMessage = "\(fullMessage) || [\(tag)]"
        }
        
        fullMessage = "\(fullMessage)\n\(message)"
        
        print(fullMessage)
        #endif
        if let tag = tag {
            CLSLogv("[%@] %@", getVaList([tag, message]))
        }
        else {
            CLSLogv("%@", getVaList([message]))
        }
    }
    
//    static func startTrackingUser(_ user:User) {
//        Crashlytics.sharedInstance().setUserIdentifier("\(user.id)")
//        Crashlytics.sharedInstance().setUserEmail(user.email)
//        Crashlytics.sharedInstance().setUserName(user.fullName)
//    }
}

