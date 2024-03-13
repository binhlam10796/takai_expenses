//
//  LoginViewModelInOutDelegate.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation
import Combine

enum LoginViewModelStatus {
    case none
    case loading
    case loginSuccess(displayName: String)
    case loginFailure
    case loginFailureWithMessage(message: FirebaseAuthManager.AuthError)
}

protocol LoginViewModelInputDelegate {
    var fam: FirebaseAuthManager? { get }
    func login(email: String, password: String)
}

protocol LoginViewModelOuputDelegate {
    var status: CurrentValueSubject<LoginViewModelStatus, Never> { get set }
}
