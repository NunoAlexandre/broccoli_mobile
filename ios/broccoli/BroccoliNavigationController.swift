//
//  DefaultNavigationBar.swift
//  broccoli
//
//  Created by Nuno on 16/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit


class BroccoliNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.topItem?.title = "Broccoli"
        self.navigationBar.barTintColor = UIColor.flatWhite()
        self.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.broccoliGreen(),
            NSFontAttributeName: UIFont(name: "American Typewriter", size: 19.0)!]
    }
    
}
