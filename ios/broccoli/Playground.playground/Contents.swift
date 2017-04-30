//: Playground - noun: a place where people can play

import UIKit

var date = Date()

let df = DateFormatter()
df.dateFormat = "yyyy-MM-dd"

print(df.string(from: date))
