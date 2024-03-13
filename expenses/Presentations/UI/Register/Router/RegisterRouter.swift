//
//  RegisterRouter.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation

//MARK: - Protocol
protocol RegisterRouterInput {
    var vc: RegisterViewController! { get }
    
    func goBack()
}

//MARK: - Implementation
class RegisterRouter: RegisterRouterInput {
    
    weak var vc: RegisterViewController!
    
    init(vc: RegisterViewController) {
        self.vc = vc
    }
    
    func goBack() {
        vc.navigationController?.popViewController(animated: true)
    }
}
