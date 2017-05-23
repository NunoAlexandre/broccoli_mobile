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
