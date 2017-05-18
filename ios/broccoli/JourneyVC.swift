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

class JourneyVC : UIViewController, PointSelectedProtocol {
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var containerView: UIScrollView!
    var graph : ScrollableGraphView!
    var journey : Journey!
    
    override open func loadView() {
        super.loadView()
        graph = Graph.new(frame: chartView.frame, delegate: self)
        containerView.plugPullToRefresh { self.fetchGraphData(graph: self.graph)}
    }
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        fetchGraphData(graph: graph)
    }
    
    func fetchGraphData(graph : ScrollableGraphView) {
        let headers = ["Authorization": " Bearer \(UserToken().peek())" ]
        
        Alamofire.request("https://nabroccoli.herokuapp.com/api/days", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                if let jsonDict = response.result.value as? [String:Any], let data = jsonDict["data"] as? [[String:Any]] {
                    self.journey = Journey(data: data)
                    graph.set(data: self.journey.levels(), withLabels: self.journey.days())
                    self.reloadGraphView(graph)
                    self.containerView.dg_stopLoading()
                }
        }
    }
    
    func reloadGraphView(_ graph: ScrollableGraphView) {
        self.chartView.subviews.forEach{$0.removeFromSuperview()}
        self.chartView.addSubview(graph)
    }

    
    func pointWasSelectedAt(index:Int, label: String, value: Double, location: CGPoint) {
        AZDialogViewController(title: "\(label) :: \(Int(value))" , message: journey.step(atIndex: index).note).aLaBroccoli().show(in: self)
    }
}
