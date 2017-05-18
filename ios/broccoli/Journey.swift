//
//  Journey.swift
//  broccoli
//
//  Created by Nuno on 18/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation

class Journey {
    let steps : [Step]
    
    init(data: [[String:Any]] ) {
        steps = data.flatMap {
            Step(day: ($0["day"] as? String)!, level: ($0["level"] as? String)!, note: ($0["note"] as? String)!)
        }
    }
    
    func days() -> [String] {
        return steps.map{$0.day}
    }
    
    func levels() -> [Double] {
        return steps.map{$0.level.value}
    }
    
    func step(atIndex i: Int) -> Step {
        return steps[i]
    }
    
    
}
