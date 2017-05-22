import Foundation
import UIKit

class Feedback {
    
    class func dayAdded() -> UIAlertController {
        return UIAlertController(title: "Saved!", message: "Well done, broccoli :)",
                                 dismissTitle: "Yay!")
    }
    
    class func duplicatedDay() -> UIAlertController {
        return UIAlertController(title: "Ups!", message: "You have already added this day.", dismissTitle: "Oke")
    }
}
