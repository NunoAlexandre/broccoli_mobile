import Foundation
import UIKit
import Chameleon

extension ScrollableGraphView {
    
    convenience init(frame: CGRect, delegate : PointSelectedProtocol) {
        self.init(frame: frame)
        backgroundFillColor = UIColor.flatWhite()
        rangeMax = 23
        lineWidth = 1
        lineColor = UIColor.white
        lineStyle = .smooth
        leftmostPointPadding = 80
        rightmostPointPadding = 80
        shouldFill = true
        fillType = .gradient
        fillGradientStartColor = UIColor.broccoliGreenLighter().withAlphaComponent(0.45)
        fillGradientEndColor = UIColor.broccoliGreen()
        dataPointSpacing = 80
        dataPointSize = 4
        dataPointFillColor = UIColor.white
        referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLineLabelColor = UIColor.black
        dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        direction = .rightToLeft
        pointSelectedDelegate = delegate
    }
}
