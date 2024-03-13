//
//  RegisterViewModelInOutDelegate.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation
import Combine

enum RegisterViewModelStatus {
    case none
    case loading
    case registerSuccess
    case registerFailure
    case registerFailureWithMessage(message: FirebaseAuthManager.AuthError)
}

protocol RegisterViewModelInputDelegate {
    var fam: FirebaseAuthManager? { get }
    func register(email: String, password: String, displayName: String)
}

protocol RegisterViewModelOuputDelegate {
    var status: CurrentValueSubject<RegisterViewModelStatus, Never> { get set }
}
