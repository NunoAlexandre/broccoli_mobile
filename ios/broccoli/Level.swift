//
//  Level.swift
//  broccoli
//
//  Created by Nuno on 18/05/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation

class Level {
    let value : Double
    
    init(_ value: String) {
        self.value = Double(["one" : 1, "two" : 2,"three" : 3, "five" : 5, "eight" : 8, "twenty_one" : 21][value]!)
    }
    
}
