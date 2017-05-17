//
//  PullToRefresh.swift
//  broccoli
//
//  Created by Nuno on 17/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit
import DGElasticPullToRefresh

extension UIScrollView {
    
    func plugPullToRefresh(onPull : @escaping () -> Void) {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.flatGreenColorDark()
        self.dg_addPullToRefreshWithActionHandler(onPull, loadingView: loadingView)
        self.dg_setPullToRefreshFillColor(UIColor.flatWhite())
        self.dg_setPullToRefreshBackgroundColor(UIColor.flatWhiteColorDark())
    }
}
