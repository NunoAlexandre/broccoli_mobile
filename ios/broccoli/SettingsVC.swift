//
//  SettingsViewController.swift
//  broccoli
//
//  Created by Nuno on 16/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class SettingsVC: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Device")
            <<< ButtonRow() { row in
                    row.title = "Logout"
                    row.cell.height = {65}
                }
                .onCellSelection { _,_ in  self.doLogout() }
    }
    
    func doLogout() {
        UserToken().remove()
        self.performSegue(withIdentifier: "onLogout", sender: nil)
    }
}
