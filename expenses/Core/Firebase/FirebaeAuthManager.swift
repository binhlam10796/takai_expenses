//
//  FirebaeAuthManager.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import FirebaseAuth
import UIKit

class FirebaseAuthManager {
    
    enum AuthError: Error {
        case emailAlreadyExists
        case invalidEmail
        case wrongPassword
        case unknownError
        
        var localizedDescription: String {
            switch self {
            case .emailAlreadyExists:
                return NSLocalizedString(Localized.fam_email_already_exists.rawValue, comment: "")
            case .invalidEmail:
                return NSLocalizedString(Localized.fam_invalid_email.rawValue, comment: "")
            case .wrongPassword:
                return NSLocalizedString(Localized.fam_incorrect_password.rawValue, comment: "")
            case .unknownError:
                return NSLocalizedString(Localized.fam_unknown_error.rawValue, comment: "")
            }
        }
    }
    
    func register(email: String, password: String, displayName: String, completionBlock: @escaping (_ success: Bool, _ error: AuthError?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error as? NSError {
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .emailAlreadyInUse:
                        completionBlock(false, .emailAlreadyExists)
                    case .invalidEmail:
                        completionBlock(false, .invalidEmail)
                    default:
                        completionBlock(false, .unknownError)
                    }
                } else {
                    completionBlock(false, .unknownError)
                }
            } else {
                let changeRequest = authResult?.user.createProfileChangeRequest()
                changeRequest?.displayName = displayName
                changeRequest?.commitChanges(completion: { (error) in
                    if error != nil {
                        completionBlock(false, .unknownError)
                    } else {
                        completionBlock(true, nil)
                    }
                })
            }
        }
    }
    
    func login(email: String, password: String, completionBlock: @escaping (_ success: Bool, _ error: AuthError?, _ displayName: String?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error as? NSError {
                if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
                    switch errorCode {
                    case .invalidEmail, .userNotFound:
                        completionBlock(false, .invalidEmail, nil)
                    case .wrongPassword:
                        completionBlock(false, .wrongPassword, nil)
                    default:
                        completionBlock(false, .unknownError, nil)
                    }
                } else {
                    completionBlock(false, .unknownError, nil)
                }
            } else {
                if let currentUser = Auth.auth().currentUser {
                    let displayName = currentUser.displayName ?? ""
                    completionBlock(true, nil, displayName)
                } else {
                    completionBlock(true, nil, nil)
                }
            }
        }
    }
}
