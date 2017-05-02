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

class LoginViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Lock
            .classic()
            .withStyle {
                $0.title = "Broccoli"
                $0.headerBlur = .extraLight
                $0.logo = LazyImage(name: "broccoli")
                $0.primaryColor = UIColor ( red: 0.3784, green: 0.7333, blue: 0.6784, alpha: 1.0 )
            }
            .onAuth { credentials in
                // Do something with credentials e.g.: save them.
                // Lock will not save these objects for you.
                // Lock will dismiss itself automatically by default.
                self.performSegue(withIdentifier: "segueOnSuccessfulLogin", sender: nil)
            }
            .present(from: self)
        
    }
    

    
    
}

