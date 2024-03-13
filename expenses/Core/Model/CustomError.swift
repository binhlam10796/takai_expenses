//
//  CustomError.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation

enum CustomError: Error {
    case noContent
    case unknow(code: String)
    case nilData
    case unauthorized
    case badRequest
    case notFound
    case forbidden
    case userNotFound
    case logoutError
    case loginError
    case generic
    case noConnection
    case urlRequestNil
    case noLocalDataFound
    case jsonDecodeError
    case tokenRefreshFailed
    
    init(errorCode: Int) {
        self = .generic
    }
}

extension CustomError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noContent:
            return NSLocalizedString(Localized.no_content_found.rawValue, comment: "")
        case .unknow(let code):
            let genericErrorMessage = NSLocalizedString(Localized.generic_localized_net_error_message.rawValue, comment: "")
            let genericErrorMessageWithFormat = String.localizedStringWithFormat(genericErrorMessage, "\(code)")
            
            return genericErrorMessageWithFormat
        case .nilData:
            return NSLocalizedString(Localized.nil_data_msg.rawValue, comment: "")
        case .unauthorized:
            return NSLocalizedString(Localized.unauthorized_message.rawValue, comment: "")
        case .badRequest:
            return NSLocalizedString(Localized.badRequest_message.rawValue, comment: "")
        case .notFound:
            return NSLocalizedString(Localized.not_found_message.rawValue, comment: "")
        case .forbidden:
            return NSLocalizedString(Localized.forbidden_message.rawValue, comment: "")
        case .userNotFound:
            return NSLocalizedString(Localized.user_not_found_message.rawValue, comment: "")
        case .logoutError:
            return NSLocalizedString(Localized.logout_error_message.rawValue, comment: "")
        case .loginError:
            return NSLocalizedString(Localized.login_error_message.rawValue, comment: "")
        case .noConnection:
            return NSLocalizedString(Localized.no_connection_error_message.rawValue, comment: "")
        case .urlRequestNil:
            return NSLocalizedString(Localized.url_request_nil.rawValue, comment: "")
        case .noLocalDataFound:
            return NSLocalizedString(Localized.no_local_data_found.rawValue, comment: "")
        case .jsonDecodeError:
            return NSLocalizedString(Localized.json_decode_error.rawValue, comment: "")
        case .generic:
            return NSLocalizedString(Localized.generic_error_message.rawValue, comment: "")
        case .tokenRefreshFailed:
            return NSLocalizedString(Localized.token_refresh_failed.rawValue, comment: "")
        }
    }
}
