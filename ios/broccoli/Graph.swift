//
//  Graph.swift
//  broccoli
//
//  Created by Nuno on 16/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit

class Graph {
    
    static func new(frame: CGRect) -> ScrollableGraphView {
        let graph = ScrollableGraphView(frame: frame)
        
        graph.backgroundFillColor = UIColor.flatWhite()
        graph.rangeMax = 23
        graph.lineWidth = 1
        graph.lineColor = UIColor.white
        graph.lineStyle = .smooth
        graph.leftmostPointPadding = 80
        graph.rightmostPointPadding = 80
        
        graph.shouldFill = true
        graph.fillType = ScrollableGraphViewFillType.gradient
        graph.fillColor = UIColor.broccoliGreen()
        graph.fillGradientType = .linear
        graph.fillGradientStartColor = UIColor.broccoliGreenLighter().withAlphaComponent(0.45)
        graph.fillGradientEndColor = UIColor.broccoliGreen()
        
        graph.dataPointSpacing = 80
        graph.dataPointSize = 4
        graph.dataPointFillColor = UIColor.white
        
        graph.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        graph.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        graph.referenceLineLabelColor = UIColor.black
        graph.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        return graph
    }

}

