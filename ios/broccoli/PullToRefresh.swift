import Foundation
import UIKit
import DGElasticPullToRefresh

extension UIScrollView {
    
    func onPull(_ action : @escaping () -> Void) {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.white
        self.dg_addPullToRefreshWithActionHandler(action, loadingView: loadingView)
        self.dg_setPullToRefreshFillColor(UIColor.broccoliGreen().withAlphaComponent(0.6))
        self.dg_setPullToRefreshBackgroundColor(UIColor.broccoliGreenLighter())
    }
}
