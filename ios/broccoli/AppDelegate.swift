//
//  AppDelegate.swift
//  broccoli
//
//  Created by Nuno on 17/04/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import UIKit
import Lock
import Auth0

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func applicationDidBecomeActive(_ application: UIApplication) {
        if let refreshToken = RefreshToken.peek() {
            Auth0.authentication().delegation(withParameters: ["refresh_token": refreshToken])
                .start { result in
                    switch(result) {
                        case .success(let credentials):
                            IdToken.save(credentials["id_token"] as! String)
                        case .failure(_):
                            IdToken.remove()
                            RefreshToken.remove()
                    }
                }
        }
    }

}

