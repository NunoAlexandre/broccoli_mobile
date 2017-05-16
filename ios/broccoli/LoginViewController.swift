//
//  FirstViewController.swift
//  broccoli
//
//  Created by Nuno on 17/04/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import UIKit
import Alamofire
import Eureka
import Lock
import Auth0

class LoginViewController : UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        if UserToken().isPresent() { didSuceedToLogin() }
        else {
            Lock
                .classic()
                .withStyle {
                    $0.title = "Broccoli"
                    $0.headerBlur = .extraLight
                    $0.logo = LazyImage(name: "broccoli")
                    $0.primaryColor = UIColor ( red: 0.3784, green: 0.7333, blue: 0.6784, alpha: 1.0 )
                }
                .onAuth {
                    _ = UserToken(token: $0.idToken!)
                    self.didSuceedToLogin()
                }
                .present(from: self)
        }
    }
    
    
    func didSuceedToLogin() {
        DispatchQueue.main.async(){
            self.performSegue(withIdentifier: "OnSuccessfulLogin", sender: nil)
        }
    }
    
}

