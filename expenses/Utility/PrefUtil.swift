//
//  PrefUtil.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation

class PrefUtil {
    // MARK: User Defaults Keys
    private struct Keys {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
    }
    
    // MARK: Save Data
    static func saveAccessToken(_ accessToken: String) {
        UserDefaults.standard.set(accessToken, forKey: Keys.accessToken)
    }
    
    static func saveRefreshToken(_ refreshToken: String) {
        UserDefaults.standard.set(refreshToken, forKey: Keys.refreshToken)
    }
    
    
    // MARK: Retrieve Data
    static func getAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: Keys.accessToken)
    }
    
    static func getRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: Keys.refreshToken)
    }
    
    
    // MARK: Clear Data
    static func clearUserData() {
        UserDefaults.standard.removeObject(forKey: Keys.accessToken)
        UserDefaults.standard.removeObject(forKey: Keys.refreshToken)
    }
}
