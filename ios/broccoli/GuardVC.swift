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
    @IBOutlet weak var getStartedButton: UIButton!
    
    @IBAction func showLock(_ button: UIButton) {
        Lock
            .classic()
            .withOptions{
                $0.closable = true
                $0.scope = "openid offline_access"
                $0.parameters = ["device": UIDevice.current.name]
            }
            .withStyle {
                $0.title = "Broccoli"
                $0.headerColor = UIColor.broccoliGreenLighter()
                $0.logo = LazyImage(name: "broccoli")
                $0.backgroundColor = UIColor.broccoliGreenLighter()
                $0.primaryColor = UIColor.broccoliGreenLighter()
                $0.titleColor = UIColor.broccoliYellow()
            }
            .onAuth {
                print("refreshToken: \($0.refreshToken ?? "<none>")")
                IdToken.save($0.idToken!)
                RefreshToken.save($0.refreshToken!)
                button.isHidden = true
                self.didSuceedToLogin()
            }
            .present(from: self)
    }
    
    override func viewDidLoad() {
        if IdToken.isPresent() { didSuceedToLogin() }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getStartedButton.isHidden = IdToken.isPresent()
    }
    
    func didSuceedToLogin() {
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: "OnSuccessfulLogin", sender: nil)
        }
    }
}

