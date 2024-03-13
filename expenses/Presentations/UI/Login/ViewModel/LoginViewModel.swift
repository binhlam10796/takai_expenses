//
//  LoginViewModel.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation
import Combine

protocol LoginViewModelDelegate: LoginViewModelInputDelegate, LoginViewModelOuputDelegate {}

class LoginViewModel: LoginViewModelDelegate {
    
    var fam: FirebaseAuthManager?
    var status: CurrentValueSubject<LoginViewModelStatus, Never> = .init(.none)
    
    func login(email: String, password: String) {
        Task {
            status.send(.loading)
            fam?.login(email: email, password: password) {[weak self] (success, error, displayName) in
                guard let `self` = self else { return }
                if (success) {
                    status.send(.loginSuccess(displayName: displayName ?? "UNKNOWN"))
                } else {
                    if let authError = error {
                        status.send(.loginFailureWithMessage(message: authError))
                    } else {
                        status.send(.loginFailure)
                    }
                }
            }
        }
    }
}
