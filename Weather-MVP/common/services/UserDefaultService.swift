//
//  UserDefaultHelper.swift
//  Weather
//
//  Created by Godwin Olorunshola on 13/12/2019.
//  Copyright © 2019 Godwin Olorunshola. All rights reserved.
//

import Foundation

protocol UserDefaultsProtocol {
    func setTheme(value : Theme)
    func getTheme() -> Theme
}

struct UserDefaultService : UserDefaultsProtocol{
    
     func setTheme(value: Theme) {
        UserDefaults.standard.set(value.rawValue, forKey: UserDefaultsKeys.appTheme.rawValue)
    }
    
     func getTheme() -> Theme {
        return Theme(rawValue: UserDefaults.standard.string(forKey: UserDefaultsKeys.appTheme.rawValue) ?? Theme.forest.rawValue) ?? .forest
    }
    
}



enum UserDefaultsKeys : String{
    case appTheme
}
