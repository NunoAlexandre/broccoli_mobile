//
//  DefaultNavigationBar.swift
//  broccoli
//
//  Created by Nuno on 16/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit

class DefaultNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.barTintColor = UIColor.flatForestGreen()
        self.tintColor = UIColor.flatForestGreen()
        self.backgroundColor = UIColor.flatForestGreen()
        self.tintColor = UIColor.flatWhite()
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func draw(_ rect: CGRect) {
        
    }
    
}
