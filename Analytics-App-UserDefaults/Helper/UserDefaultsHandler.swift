import Foundation

enum DefaultsKeys: String{
    case configuration = "configuration"
}

struct Defaults{
    static func value<T>(forKey key: DefaultsKeys) -> T?{
        UserDefaults.standard.value(forKey: key.rawValue) as? T
    }
    
    static func valueAny(forKey key: DefaultsKeys) -> Any?{
        print(key.rawValue)
        return UserDefaults.standard.value(forKey: key.rawValue)
    }
    
    static func storeAny(value: Any?, key: DefaultsKeys){
        UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    static func store<T: Codable>(value: T, key: DefaultsKeys){
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey:key.rawValue)
    }
    
    static func value<T: Codable>(structForKey key: DefaultsKeys) -> T?{
        if let data = UserDefaults.standard.value(forKey:key.rawValue) as? Data {
            let value = try? PropertyListDecoder().decode(T.self, from: data)
            return value
        }
        return nil
    }
    
    static func remove(forKey key: DefaultsKeys){
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
    
    static func removeAllValues(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}
