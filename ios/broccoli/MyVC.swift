//
//  MyVC.swift
//  broccoli
//
//  Created by Nuno on 13/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import UIKit
import Chameleon
import Alamofire

class MyVC: UIViewController {
//    var lineChartView: LineChartView!
    @IBOutlet weak var chartView: UIView!
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let graphView = ScrollableGraphView(frame: chartView.frame)
//        let data: [Double] = getData()//[1, 2, 5, 8, 21]
        let labels = ["one", "two", "three", "four", "five", "six"]
        
        
        graphView.backgroundFillColor = UIColor.flatWhite()//UIColor.white//UIColor.darkGray//("#333333")
        graphView.rangeMax = 21
        graphView.lineWidth = 1
        graphView.lineColor = UIColor.white//("#777777")
        graphView.lineStyle = .smooth
        
        graphView.shouldFill = true
        graphView.fillType = ScrollableGraphViewFillType.gradient
        graphView.fillColor = UIColor.flatGreen()//UIColor.cyan//colorFromHex("#555555")
        graphView.fillGradientType = .linear
        graphView.fillGradientStartColor = UIColor.flatGreen()//UIColor.cyan//UIColor.colorFromHex("#555555")
        graphView.fillGradientEndColor = UIColor.flatGreen()//UIColor.darkText//UIColor.colorFromHex("#444444")
        
        graphView.dataPointSpacing = 80
        graphView.dataPointSize = 3
        graphView.dataPointFillColor = UIColor.white//()
        
        graphView.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        graphView.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        graphView.referenceLineLabelColor = UIColor.black
        graphView.dataPointLabelColor = UIColor.white.withAlphaComponent(0.5)
        
        setData(graph: graphView, withLabels: labels)
    }
    
    func setData(graph : ScrollableGraphView, withLabels labels: [String]) {
        let headers = ["Authorization": " Bearer \(UserToken().peek())" ]
        
        Alamofire.request("https://nabroccoli.herokuapp.com/api/days", method: .get,
                          encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                if let jsonDict = response.result.value as? [String:Any],
                    let dataArray = jsonDict["data"] as? [[String:Any]] {
                    let levels = dataArray.flatMap { self.levelAsNum(value: ($0["level"] as? String)!) }
                    
                    graph.set(data: levels, withLabels: labels)
                    self.chartView.addSubview(graph)

                }
        }
    }
    
    func levelAsNum(value : String) -> Double {
        return Double(["one" : 1, "two" : 2,"three" : 3, "five" : 5, "eight" : 8, "twenty_one" : 21][value]!)
    }

    
    
}
