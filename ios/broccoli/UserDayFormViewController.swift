//
//  UserDayFormViewController.swift
//  broccoli
//
//  Created by Nuno on 23/04/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import UIKit
import Eureka
import Alamofire

class UserDayFormViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section()
            <<< DateRow("day") { row in
                row.title = "On the..."
                row.add(rule: RuleRequired())
                row.value = Date()
            }
            <<< ActionSheetRow<String>("level") {
                $0.title = "My day was a..."
                $0.selectorTitle = "Pick a number"
                $0.options = ["one","two","three", "five", "eight", "twenty_one"]
                $0.add(rule: RuleRequired())
            }
            <<< TextAreaRow("note") { row in
                row.title = "Note"
                row.add(rule: RuleMaxLength(maxLength: 400))
            }
            <<< ButtonRow() { row in
                row.title = "Save"
                row.cell.height = {90}
                }
                .onCellSelection {  cell, row in
                    let styled = DateFormatter()
                    styled.dateFormat = "yyyy-MM-dd"
                    let userDay = ["user_day" : ["day" : styled.string(from: (self.form.values()["day"] as! Date)),
                                                 "level" : self.form.values()["level"] as! String,
                                                 "note" : self.form.values()["note"] as! String]]
                    
                    let headers = ["Authorization": " Bearer \(UserToken().peek())" ]
                    
                    Alamofire.request("https://nabroccoli.herokuapp.com/api/days", method: .post, parameters: userDay,
                                      encoding: JSONEncoding.default, headers: headers)
                        .responseJSON { response in
                            print(response)
                            if let status = response.response?.statusCode {
                                switch(status) {
                                case 201:
                                    let alert = UIAlertController(title: "Saved!", message: "well done, broccoli :)",
                                                            preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Yay", style: .default, handler: { (action) -> Void in }))
                                    self.present(alert, animated: true, completion: nil)
                                case 422:
                                    let alert = UIAlertController(title: "Ups!",
                                                                  message: "You have already registered the selected day.",
                                                                  preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { (action) -> Void in }))
                                    self.present(alert, animated: true, completion: nil)
                                case 401:
                                    let alert = UIAlertController(title: "Ups!",
                                                                  message: "A login a week keeps the hacker asleep!",
                                                                  preferredStyle: .alert)
                                    alert.addAction(UIAlertAction(title: "Oke", style: .default, handler: { (action) -> Void in }))
                                    self.present(alert, animated: true, completion: nil)
                                default:
                                    print("error with response status: \(status)")
                                }
                            }
                    }
                }
    }
    
}
