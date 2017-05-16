//
//  UserToken.swift
//  broccoli
//
//  Created by Nuno on 11/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation

class UserToken {
    let key = "broccoli.user.token"
    
    init() {}
    
    init(token: String) {
        UserDefaults.standard.set(token, forKey: key)
    }
    
    func peek() -> String {
        return UserDefaults.standard.value(forKey: key) as! String
    }
    
    func isMissing() -> Bool {
        return UserDefaults.standard.value(forKey: key) == nil
    }
    
    func isPresent() -> Bool {
        return !isMissing()
    }
}
