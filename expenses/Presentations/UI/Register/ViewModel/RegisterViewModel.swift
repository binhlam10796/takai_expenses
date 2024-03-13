//
//  RegisterViewModel.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation
import Combine

protocol RegisterViewModelDelegate: RegisterViewModelInputDelegate, RegisterViewModelOuputDelegate {}

class RegisterViewModel: RegisterViewModelDelegate {
    
    
    var fam: FirebaseAuthManager?
    var status: CurrentValueSubject<RegisterViewModelStatus, Never> = .init(.none)
    
    
    func register(email: String, password: String, displayName: String) {
        Task {
            status.send(.loading)
            fam?.register(email: email, password: password, displayName: displayName) { [weak self] (success, error) in
                guard let `self` = self else { return }
                if success {
                    status.send(.registerSuccess)
                } else {
                    if let authError = error {
                        status.send(.registerFailureWithMessage(message: authError))
                    } else {
                        status.send(.registerFailure)
                    }
                }
            }
        }
    }
}
