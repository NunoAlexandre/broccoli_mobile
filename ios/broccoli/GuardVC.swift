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
            .withStyle {
                $0.title = "Broccoli"
                $0.headerColor = UIColor.broccoliGreenLighter()
                $0.logo = LazyImage(name: "broccoli")
                $0.backgroundColor = UIColor.broccoliGreenLighter()
                $0.primaryColor = UIColor.broccoliGreenLighter()
                $0.titleColor = UIColor.broccoliYellow()
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
        if UserToken().isPresent() { didSuceedToLogin() }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        getStartedButton.isHidden = UserToken().isPresent()
    }
    
    func didSuceedToLogin() {
        DispatchQueue.main.async() {
            self.performSegue(withIdentifier: "OnSuccessfulLogin", sender: nil)
        }
    }

}

