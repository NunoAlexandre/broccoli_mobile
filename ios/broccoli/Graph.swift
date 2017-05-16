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
        graph.rangeMax = 21
        graph.lineWidth = 1
        graph.lineColor = UIColor.white
        graph.lineStyle = .smooth
        
        graph.shouldFill = true
        graph.fillType = ScrollableGraphViewFillType.gradient
        graph.fillColor = UIColor.flatGreen()
        graph.fillGradientType = .linear
        graph.fillGradientStartColor = UIColor.flatGreen()
        graph.fillGradientEndColor = UIColor.flatGreen()
        
        graph.dataPointSpacing = 80
        graph.dataPointSize = 3
        graph.dataPointFillColor = UIColor.white
        
        graph.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        graph.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        graph.referenceLineLabelColor = UIColor.black
        graph.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        return graph
    }

}

