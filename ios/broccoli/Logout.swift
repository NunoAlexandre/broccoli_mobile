//
//  Logout.swift
//  broccoli
//
//  Created by Nuno on 20/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func performLogout() {
        IdToken.remove()
        RefreshToken.remove()
        let guardVC = UIStoryboard.main().instantiateInitialViewController()!
        self.present(guardVC, animated: true, completion: nil)
    }
    
    func performExplainedLogout() {
        let alert = UIAlertController(title: "Ups!",
                                   message: "The time has come: you need to login again!",
                                   preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default,
                                   handler: { _ in self.performLogout() }))
        self.present(alert)
    }
    
    func present(_ vc : UIViewController) -> Void {
        self.present(vc, animated: true, completion: nil)

    }
}

extension UIStoryboard {
    class func main() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }
}
