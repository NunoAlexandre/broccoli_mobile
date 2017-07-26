//
//  JourneyStats.swift
//  Broccoli
//
//  Created by Nuno on 25/07/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import SigmaSwiftStatistics


class JourneyStats {
    private let journey : Journey
    
    init(_ journey: Journey ) {
        self.journey = journey
    }
    
    func average() -> Int {
        return calculate { Sigma.average($0)! }
    }
    
    func median() -> Int {
        return calculate { Sigma.median($0)! }
    }
    
    private func calculate(_ function : ([Double]) -> Double) -> Int {
        return Int(function(journey.daysList.map{Double($0.level)}))
    }
}
