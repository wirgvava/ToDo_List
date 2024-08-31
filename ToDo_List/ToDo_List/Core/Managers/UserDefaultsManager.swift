//
//  UserDefaultsManager.swift
//  ToDo_List
//
//  Created by Konstantine Tsirgvava on 30.08.24.
//

import Foundation

class UserDefaultsManager {
    
    enum UserDefaultKeys: String {
        case hasLaunchedBefore
    }
    
    // - Bool
    static func save(_ bool: Bool, forKey: UserDefaultKeys) {
        UserDefaults.standard.set(bool, forKey: forKey.rawValue)
    }
    
    static func get(forKey: UserDefaultKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey.rawValue)
    }
}
