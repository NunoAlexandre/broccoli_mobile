//
//  Step.swift
//  broccoli
//
//  Created by Nuno on 18/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation


class Step {
    let day : String
    let level : Level
    let note : String

    init(day: String, level: String, note: String) {
        self.day = day
        self.level = Level(level)
        self.note = note
    }
    
    private func asNum(value : String) -> Double {
        return Double(["one" : 1, "two" : 2,"three" : 3, "five" : 5, "eight" : 8, "twenty_one" : 21][value]!)
    }
    
}
