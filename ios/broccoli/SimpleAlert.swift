import Foundation
import UIKit

extension UIAlertController {
    convenience init(title: String, message: String, dismissTitle: String) {
        self.init(title: title, message: message, preferredStyle: .alert)
        self.addAction(UIAlertAction(title: dismissTitle, style: .default, handler: nil))
    }
}
