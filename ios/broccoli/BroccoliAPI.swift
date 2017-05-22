import Foundation
import Alamofire

class BroccoliAPI {
    private let apiURL : String!
    
    init(apiURL : String = "https://nabroccoli.herokuapp.com/api/") {
        self.apiURL = apiURL
    }
    
    func journey(onSuccess: @escaping ([[String:Any]]) -> Void, onUnauthorized: @escaping () -> Void) {
        doGet("days").responseJSON { response in
            if let status = response.response?.statusCode {
                switch(status) {
                    case 200: onSuccess(response.json())
                    case 401: onUnauthorized()
                    default:  print("error with response status: \(status)")
                }
            }
        }
    }
    
    func saveDay(_ userDay : Parameters,
                 onSuccess : @escaping () -> Void,
                 onDuplicateDay : @escaping () -> Void,
                 onUnauthorized: @escaping () -> Void)
    {
        doPost("days", params: userDay)
            .responseJSON { response in
                if let status = response.response?.statusCode {
                    switch(status) {
                        case 201: onSuccess()
                        case 422: onDuplicateDay()
                        case 401: onUnauthorized()
                        default:print("error with response status: \(status)")
                    }
                }
        }

    }
    
    private func headers() -> [String:String] {
        return ["Authorization": " Bearer \(IdToken.peek())"]
    }
    
    private func doGet(_ urn : String) -> DataRequest {
        return Alamofire.request(apiURL+urn, method: .get,
                                 encoding: JSONEncoding.default, headers: headers())
    }
    
    private func doPost(_ urn : String, params : Parameters) -> DataRequest {
        return Alamofire.request(apiURL+urn, method: .post, parameters: params,
                                 encoding: JSONEncoding.default, headers: headers())

    }

    
}

extension DataResponse {
    func json() -> [[String:Any]] {
        return ((self.result.value as! [String:Any])["data"] as! [[String:Any]])
    }
}
