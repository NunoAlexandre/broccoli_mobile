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

class JourneyVC : UIViewController {
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
    }
    
    func fetchGraphData(graph : ScrollableGraphView) {
        let headers = ["Authorization": " Bearer \(UserToken().peek())" ]
        
        Alamofire.request("https://nabroccoli.herokuapp.com/api/days", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                if let jsonDict = response.result.value as? [String:Any],
                    let data = jsonDict["data"] as? [[String:Any]] {
                    graph.set(data: self.levels(data), withLabels: self.labels(data))
                    self.reloadGraphView(graph)
                    self.containerView.dg_stopLoading()
                }
        }
    }
    
    func reloadGraphView(_ graph: ScrollableGraphView) {
        self.chartView.subviews.forEach{$0.removeFromSuperview()}
        self.chartView.addSubview(graph)
    }
    
    func levels(_ data: [[String:Any]]) -> [Double] {
        return data.flatMap { self.levelAsNum(value: ($0["level"] as? String)!) }
    }
    
    func labels(_ data: [[String:Any]]) -> [String] {
        return data.flatMap { $0["day"] as? String! }
    }
    
    
    func levelAsNum(value : String) -> Double {
        return Double(["one" : 1, "two" : 2,"three" : 3, "five" : 5, "eight" : 8, "twenty_one" : 21][value]!)
    }
}
