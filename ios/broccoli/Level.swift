import Foundation

class Level {
    let value : Int
    
    init(_ value: String) {
        self.value = ["one" : 1, "two" : 2,"three" : 3, "five" : 5, "eight" : 8, "twenty_one" : 21][value]!
    }

}
