//
//  FacebookHelper.swift
//  Udely
//
//  Created by Hernan Paez on 13/11/17.
//  Copyright © 2017 Infinixsoft. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import RxCocoa
import RxSwift

class FacebookHelper {
    typealias FacebookLoginInfo = (fb_id:String, token:String)
    
    init() { fatalError("This class shouldn't be instantiated") }
    
    static func login(fromController vc:UIViewController) -> Single<User> {
        
        return facebookLogin(controller: vc)
            .flatMap { (success) in
                return FacebookHelper.requestFacebookData()
            }
            .flatMap { (info) -> Single<User> in
                return FacebookHelper.login(withFacebookInfo: info)
        }
    }
    
    fileprivate static func facebookLogin(controller vc:UIViewController) -> Single<Bool> {
        return Single.create(subscribe: { (single) -> Disposable in
            let login = FBSDKLoginManager()
            login.logOut()
            login.logIn(withReadPermissions: ["public_profile", "email"], from: vc) {(result, error) in
                if error != nil {
                    single(.error(APPError(message: "Can't connect with Facebook")))
                }
                else if result?.isCancelled == true {
                    single(.error(APPError(message: "Facebook login cancelled")))
                }
                else {
                    single(.success(true))
                }
            }
            
            return Disposables.create()
        })
    }
    
    fileprivate static func requestFacebookData() -> Single<FacebookLoginInfo> {
        guard let token = FBSDKAccessToken.current().tokenString else {
            return Single.error(APPError(message: "Not logged in with Facebook"))
        }
        
        return Single.create(subscribe: { (single) -> Disposable in
            
            let request = FBSDKGraphRequest(graphPath: "me", parameters: nil)
            let fb_req = request?.start(completionHandler: { (connection, result, error) in
                if error != nil {
                    single(.error(APPError(message: "Can't obtain information from Facebook ")))
                }
                else if let result = result as? [String : Any],
                    let id = result["id"] as? String {
                    single(.success((fb_id: id, token: token)))
                }
            })
            
            return Disposables.create {
                fb_req?.cancel()
            }
        })
        
    }
    
    fileprivate static func login(withFacebookInfo info:FacebookLoginInfo) -> Single<User> {
        let req = RegisterFB(info: info)
        return req.execute()
    }
    
    
}
