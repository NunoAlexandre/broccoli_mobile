//
//  MainAreaViewController.swift
//  broccoli
//
//  Created by Nuno on 23/04/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import UIKit

class MainAreaViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.setViewControllers([(self.storyboard?.instantiateViewController(withIdentifier: "UserDayViewController"))!],
                                 direction: .forward, animated: true, completion: nil)
        // Do any additional setup after loading the view.
    }

    
    
}
