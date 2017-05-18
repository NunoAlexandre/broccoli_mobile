//
//  Popup.swift
//  broccoli
//
//  Created by Nuno on 18/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit

extension AZDialogViewController {
    
    func aLaBroccoli() -> AZDialogViewController {
        self.dismissDirection = .top
        self.dismissWithOutsideTouch = true
        self.showSeparator = true
        self.imageHandler = { imageView in
            imageView.image = UIImage(named: "broccoli")
            imageView.contentMode = .scaleAspectFit
            return true
        }
        return self
    }
}
