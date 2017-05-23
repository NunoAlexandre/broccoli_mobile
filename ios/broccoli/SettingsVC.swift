import Foundation
import UIKit
import Eureka

class SettingsVC: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Device")
            <<< ButtonRow() {
                    $0.title = "Logout"
                    $0.cell.height = {65}
                }
                .onCellSelection { _,_ in  self.performLogout() }
    }
}
