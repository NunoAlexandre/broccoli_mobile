//
//  MyVC.swift
//  broccoli
//
//  Created by Nuno on 13/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit
import Charts

class MyVC: UIViewController {
    var lineChartView: LineChartView!
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let ys1 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        let ys2 = Array(1..<10).map { x in return cos(Double(x) / 2.0 / 3.141) }
        
        let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let yse2 = ys2.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        let data = LineChartData()
        let ds1 = LineChartDataSet(values: yse1, label: "Hello")
        ds1.colors = [NSUIColor.red]
        data.addDataSet(ds1)
        
        let ds2 = LineChartDataSet(values: yse2, label: "World")
        ds2.colors = [NSUIColor.blue]
        
        data.addDataSet(ds2)
        lineChartView = LineChartView(frame: self.view.frame)

        lineChartView.data = data
        
        lineChartView.gridBackgroundColor = NSUIColor.white
        
        lineChartView.chartDescription?.text = "Linechart Demo"
        
        self.view.addSubview(lineChartView)
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        lineChartView.animate(xAxisDuration: 0.0, yAxisDuration: 1.0)
    }
    
    
}
