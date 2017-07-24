//
//  CachedJourney.swift
//  Broccoli
//
//  Created by Nuno on 24/07/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation

class JourneyCache {
    private static let cacheKey = "broccoli.cached.journey"
    
    class func save(_ journeyData : [[String: Any]]) {
        UserDefaults.standard.set(journeyData, forKey: cacheKey)
    }
    
    class func map(_ journeyConsumer: @escaping (Journey) -> Void) {
        if let cachedJourneyData = UserDefaults.standard.value(forKey: cacheKey) {
            journeyConsumer(Journey(data: cachedJourneyData as! [[String : Any]]))
        }
    }
}
