//  TODO: I want later on to use auth0/SimpleKeychain and to DRY this
import Foundation

class IdToken {
    static private let key = "broccoli.user.token.id"
    
    class func save(_ token: String) {
        UserDefaults.standard.set(token, forKey: self.key)
    }
    
    class func peek() -> String {
        return UserDefaults.standard.value(forKey: self.key) as! String
    }
    
    class func isMissing() -> Bool {
        return UserDefaults.standard.value(forKey: self.key) == nil
    }
    
    class func isPresent() -> Bool {
        return !isMissing()
    }
    
    class func remove() {
       UserDefaults.standard.removeObject(forKey: self.key)
       UserDefaults.standard.synchronize()
    }
}

class RefreshToken {
    static private let key = "broccoli.user.token.refresh"
    
    class func save(_ token: String) {
        UserDefaults.standard.set(token, forKey: self.key)
    }
    
    class func peek() -> String? {
        return UserDefaults.standard.value(forKey: self.key) as? String
    }
    
    class func isPresent() -> Bool {
        return UserDefaults.standard.value(forKey: self.key) != nil
    }
    
    class func remove() {
        UserDefaults.standard.removeObject(forKey: self.key)
        UserDefaults.standard.synchronize()
    }
}
