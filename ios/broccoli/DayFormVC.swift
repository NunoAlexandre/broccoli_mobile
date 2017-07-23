import UIKit
import Eureka
import Alamofire

class DayFormVC : FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("Your day")
            <<< DateRow("day") {
                $0.title = "Day"
                $0.add(rule: RuleRequired())
                $0.maximumDate = Date()
                $0.value = Date()
            }
            <<< ActionSheetRow<String>("level") {
                $0.title = "Level"
                $0.selectorTitle = "The higher, the better your day was. "
                $0.options = ["7","6","5","4","3","2","1"]
                $0.add(rule: RuleRequired())
            }
            <<< TextAreaRow("note") {
                $0.title = "Note"
                $0.add(rule: RuleMaxLength(maxLength: 400))
            }
            <<< ButtonRow() {
                    $0.title = "Save"
                    $0.cell.height = {90}
                }
                .onCellSelection { _, _ in
                    BroccoliAPI().saveDay(self.userDay(from: self.form),
                      onSuccess: {self.present(Feedback.dayAdded())},
                      onDuplicateDay: {self.present(Feedback.duplicatedDay())},
                      onUnauthorized: self.performExplainedLogout)
                }
    }
    
    private func asString(_ date : Date) -> String {
        let styled = DateFormatter()
        styled.dateFormat = "yyyy-MM-dd"
        return styled.string(from: date)
    }
    
    func userDay(from form: Form) -> Parameters {
        return ["user_day" : ["day" : self.asString(self.form.values()["day"] as! Date),
                          "level" : self.form.values()["level"] as? String,
                          "note" : self.form.values()["note"] as? String]]
    }
    
}
