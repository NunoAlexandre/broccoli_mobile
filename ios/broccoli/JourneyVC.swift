//
//  JourneyVC.swift
//  broccoli
//
//  Created by Nuno on 13/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit
import Chameleon
import Alamofire
import Lock
import DGElasticPullToRefresh
import Charts

class JourneyVC : UIViewController, ChartViewDelegate {
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var containerView: UIScrollView!
    var graph : ScrollableGraphView!
    
    override open func loadView() {
        super.loadView()
        graph = Graph.new(frame: chartView.frame)
        containerView.plugPullToRefresh { self.fetchGraphData(graph: self.graph)}
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        fetchGraphData(graph: Graph.new(frame: chartView.frame))
        
//         Do any additional setup after loading the view.
        

    }
    
    func fetchGraphData(graph : ScrollableGraphView) {
        let headers = ["Authorization": " Bearer \(UserToken().peek())" ]
        
        Alamofire.request("https://nabroccoli.herokuapp.com/api/days", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                if let jsonDict = response.result.value as? [String:Any],
                    let data = jsonDict["data"] as? [[String:Any]] {
                    graph.set(data: self.levels(data), withLabels: self.labels(data))
                    self.reloadGraphView(graph)
                    self.tempFillChart(json: data)
                    self.containerView.dg_stopLoading()
                }
        }
    }
    
    func tempFillChart(json: [[String:Any]]) {
        let data = LineChartData()
        let ds1 = asEntries(json)
        ds1.colors = [UIColor.broccoliGreenLighter()]
        ds1.fillAlpha = 1.0
        ds1.mode = .cubicBezier
        ds1.drawFilledEnabled = true
        ds1.fillColor = UIColor.broccoliGreen()
        
        data.addDataSet(ds1)
        
        let lineChartView = LineChartView(frame: self.chartView.frame)
        
        
        lineChartView.highlightPerDragEnabled = false
        lineChartView.highlightPerTapEnabled = true
        lineChartView.maxHighlightDistance = 30
        
        lineChartView.backgroundColor = UIColor.flatWhite()
        
        
        lineChartView.drawMarkers = false
        
        
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.data = data
        lineChartView.legend.enabled = false
        lineChartView.chartDescription?.enabled = false
        
        lineChartView.leftAxis.labelPosition = .insideChart
        
        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.drawBordersEnabled = false
        
        lineChartView.leftAxis.drawAxisLineEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.enabled = false
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.minOffset = 0
        lineChartView.setViewPortOffsets(left: 0, top: 20, right: 0, bottom: 0)
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.rightAxis.drawAxisLineEnabled = false

        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.gridBackgroundColor = NSUIColor.white
        lineChartView.noDataText = "Niente!"
        lineChartView.chartDescription?.text = "Linechart Demo"
        lineChartView.setVisibleXRangeMaximum(4)
        lineChartView.animate(yAxisDuration: 2, easingOption: .easeInCubic)
        
        lineChartView.delegate = self
        
        self.chartView.subviews.forEach{$0.removeFromSuperview()}

        self.chartView.addSubview(lineChartView)
    }
    
    func reloadGraphView(_ graph: ScrollableGraphView) {
//        self.chartView.subviews.forEach{$0.removeFromSuperview()}
//        self.chartView.addSubview(graph)
    }
    
    func levels(_ data: [[String:Any]]) -> [Double] {
        return data.flatMap { self.levelAsNum(($0["level"] as? String)!) }
    }
    
    func asEntries(_ data: [[String:Any]]) -> LineChartDataSet {
        return LineChartDataSet(values: data.enumerated().map { i, values in
            return ChartDataEntry(x: Double(i), y: levelAsNum((values["level"] as? String)!),
                                  data: ["note": values["note"] as? String] as AnyObject)},
                                label: "Hello!")
    }
    
    func labels(_ data: [[String:Any]]) -> [String] {
        return data.flatMap { $0["day"] as? String! }
    }
    
    
    func levelAsNum(_ value : String) -> Double {
        return Double(["one" : 1, "two" : 2,"three" : 3, "five" : 5, "eight" : 8, "twenty_one" : 21][value]!)
    }
    
    
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print("Hello there! ?\(entry.data)")
    }
}
