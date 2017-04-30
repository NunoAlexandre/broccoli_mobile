//
//  SignupViewController.swift
//  broccoli
//
//  Created by Nuno on 18/04/2017.
//  Copyright © 2017 nunoalexandre. All rights reserved.
//

import Foundation
import Eureka
import Alamofire

class SignupFormViewController : FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Become a Broccoli!") { section in
                var customSection = HeaderFooterView<UIView>(.class)
                customSection.onSetupView = { view, section in
                    view.backgroundColor = .white
                }
                section.header = customSection
                section.header?.height = {0}
                section.footer = customSection
                section.footer?.height = {60}
                section.reload()
            }
            <<< NameRow() {
                    $0.tag = "name"
                    $0.title = "Name"
                    $0.placeholder = "your name goes here"
                    $0.add(rule: RuleRequired())
                    $0.validationOptions = .validatesOnChange
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            <<< EmailRow() {
                    $0.tag = "email"
                    $0.title = "Email"
                    $0.placeholder = "your email goes here"
                    $0.add(rule: RuleRequired())
                    $0.add(rule: RuleEmail())
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            <<< PasswordRow() {
                    $0.tag = "password"
                    $0.title = "Password"
                    $0.placeholder = "your password gos here"
                    $0.add(rule: RuleRequired())
                    $0.add(rule: RuleMinLength(minLength: 8))
                }
            <<< PasswordRow() {
                    $0.tag = "confirmPassword"
                    $0.title = "Confirm password"
                    $0.placeholder = "confirm"
                    $0.add(rule: RuleRequired())
                    $0.add(rule: RuleEqualsToRow(form: form, tag: "password"))
                }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            <<< ButtonRow() { row in
                    row.title = "Signup"
                }
                .cellSetup { cell, row in
                    cell.height = {90}
                }
                .onCellSelection {  cell, row in
                    let parameters: [String: Any] = ["user": ["name" : self.form.values()["name"] as! String, "email" : self.form.values()["email"] as! String, "password" : self.form.values()["password"] as! String]]
                    
                    Alamofire.request("https://nabroccoli.herokuapp.com/api/users", method: .post, parameters: parameters, encoding: JSONEncoding.default)
                        .responseJSON { response in
                            print(response)
                            //to get status code
                            if let status = response.response?.statusCode {
                                switch(status) {
                                    case 201:
                                        let alert = UIAlertController(title: "Success!",
                                                                      message: "You are now a broccoli :)",
                                                                      preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { (action) -> Void in }))
                                        self.present(alert, animated: true, completion: nil)
                                    case 422:
                                        let alert = UIAlertController(title: "Ups!",
                                                                      message: "Email has already been taken!",
                                                                      preferredStyle: .alert)
                                        alert.addAction(UIAlertAction(title: "Go back", style: .default, handler: { (action) -> Void in }))
                                        self.present(alert, animated: true, completion: nil)
                                    default:
                                        print("error with response status: \(status)")
                                    }
                            }
                            
                    }
                }
        
    }
    
    override func loadView() {
        super.loadView()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
