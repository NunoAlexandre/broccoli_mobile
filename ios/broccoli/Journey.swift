import Foundation

class Journey {
    private let daysList : [Day]
    
    init(data: [[String:Any]] ) {
        daysList = data.flatMap {
            Day(day: ($0["day"] as? String)!, level: ($0["level"] as? Int)!, note: ($0["note"] as? String)!)
        }
    }
    
    func days() -> [String] {
        return daysList.map{$0.day}
    }
    
    func levels() -> [Double] {
        return daysList.map{Double($0.level)}
    }
    
    func day(atIndex i: Int) -> Day {
        return daysList[i]
    }
    
    func hasStarted() -> Bool {
        return !daysList.isEmpty
    }
    
    func isEmpty() -> Bool {
        return daysList.isEmpty
    }
}
