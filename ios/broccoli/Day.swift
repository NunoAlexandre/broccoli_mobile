import Foundation


class Day {
    let day : String
    let level : Int
    let note : String

    init(day: String, level: Int, note: String) {
        self.day = day
        self.level = level
        self.note = note
    }
    
    func weekDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self.date())
    }
    
    func date() -> Date {
        let formatter  = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: day)!
    }
    
}
