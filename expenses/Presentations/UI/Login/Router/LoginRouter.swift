//
//  LoginRouter.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation

//MARK: - Protocol
protocol LoginRouterInput {
    var vc: LoginViewController! { get }
    
    func navigateToRegisterView()
    func navigateToHomeView(displayName: String, email: String)
}

//MARK: - Implementation
class LoginRouter: LoginRouterInput {
    
    weak var vc: LoginViewController!
    
    init(vc: LoginViewController) {
        self.vc = vc
    }
    
    func navigateToRegisterView() {
        let registerVC = RegisterConfigurator().configure()
        vc.navigationController?.pushViewController(registerVC, animated: true)
    }
    
    func navigateToHomeView(displayName: String, email: String) {
        let homeVC = HomeConfigurator().configure()
        homeVC.email = email
        homeVC.displayName = displayName
        vc.navigationController?.pushViewController(homeVC, animated: true)
    }
}
