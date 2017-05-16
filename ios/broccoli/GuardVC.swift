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

class GuardVC : UIViewController {
    
    @IBAction func showLock(_ button: UIButton) {
        Lock
            .classic()
            .withStyle {
                $0.title = "Broccoli"
                $0.headerBlur = .extraLight
                $0.logo = LazyImage(name: "broccoli")
                $0.primaryColor = UIColor.flatGreenColorDark()
            }
            .onAuth {
                if UserToken(token: $0.idToken!).isPresent() {
                    button.isHidden = true
                    self.didSuceedToLogin()
                }
            }
            .present(from: self)
    }
    
    override func viewDidLoad() {
        if UserToken().isPresent() {
            didSuceedToLogin() }
    }
    
    
    func didSuceedToLogin() {
        DispatchQueue.main.async(){
            print("Will perform segue")
            self.performSegue(withIdentifier: "OnSuccessfulLogin", sender: nil)
        }
    }

    
}

