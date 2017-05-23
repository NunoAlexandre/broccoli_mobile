import Foundation
import UIKit

extension UIViewController {
    
    func present(_ vc : UIViewController) -> Void {
        self.present(vc, animated: true, completion: nil)
    }
    
    func performExplainedLogout() {
        self.present(Feedback.loginRequired(handler: {_ in self.performLogout()}))
    }
    
    func performLogout() {
        IdToken.remove()
        RefreshToken.remove()
        self.present(UIStoryboard.main().guardVC())
    }
}

extension UIStoryboard {
    class func main() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: nil) }
    func guardVC() -> UIViewController { return instantiateInitialViewController()! }
}
