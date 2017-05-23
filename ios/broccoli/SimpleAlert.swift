import Foundation
import UIKit

extension UIAlertController {
    convenience init(title: String, message: String, dismissTitle: String,
                     onDismiss : @escaping (UIAlertAction) -> Void = {_ in })
    {
        self.init(title: title, message: message, preferredStyle: .alert)
        self.addAction(UIAlertAction(title: dismissTitle, style: .default, handler: onDismiss))
    }
}
