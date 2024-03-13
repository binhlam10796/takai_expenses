//
//  Configurations.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation

enum API {
    
    /// Get base url value
    static var baseURL: URL {
        var baseEndpoint = ""
        do {
            baseEndpoint = try Configuration.value(for: "BASE_URL") as String
        } catch(let error) {
            LOGE("Error :\(error)")
        }
        return URL(string: baseEndpoint)!
    }
    
    /// Value indicating the time that must pass between one HTTP call and the next
    static var networkHoursDelta: Int {
        var hours = 0
        do {
            hours = try Configuration.value(for: "NETWORK_REQUEST_HOURS_DELTA") as Int
        } catch(let error) {
            print("Error :\(error)")
            hours = 0
        }
        return hours
    }

}


enum Configuration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }

    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}
