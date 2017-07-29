//
//  GroupBy.swift
//  Broccoli
//
//  Created by Nuno on 29/07/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation


extension Sequence {
    
    func groupBy<K: Hashable>(_ getKey: (Iterator.Element) -> K) -> [K:[Iterator.Element]] {
        var dict: [K:[Iterator.Element]] = [:]
        for element in self {
            let key = getKey(element)
            if case nil = dict[key]?.append(element) {
                dict[key] = [element]
            }
        }
        return dict
    }
}
