import Foundation
import UIKit

extension AZDialogViewController {
    
    convenience init(day : Day) {
        
        self.init(title: "\(day.day) :: \(day.level)", message: day.note)
        self.dismissDirection = .top
        self.dismissWithOutsideTouch = true
        self.showSeparator = true
        self.imageHandler = { imageView in
            imageView.image = UIImage(named: "broccoli")
            imageView.contentMode = .scaleAspectFit
            return true
        }
    }
    
}
