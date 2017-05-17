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

class JourneyVC : UIViewController {
    @IBOutlet weak var chartView: UIView!
    
    override open func viewDidLoad()
    {
        super.viewDidLoad()
        
        setData(graph: Graph.new(frame: chartView.frame))
    }
    
    func setData(graph : ScrollableGraphView) {
        let headers = ["Authorization": " Bearer \(UserToken().peek())" ]
        
        Alamofire.request("https://nabroccoli.herokuapp.com/api/days", method: .get, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                if let jsonDict = response.result.value as? [String:Any],
                    let data = jsonDict["data"] as? [[String:Any]] {
                    graph.set(data: self.levels(data), withLabels: self.labels(data))
                    self.chartView.addSubview(graph)
                }
        }
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
