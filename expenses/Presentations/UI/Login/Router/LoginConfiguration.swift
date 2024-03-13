//
//  LoginConfiguration.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation
import Swinject

protocol LoginConfiguratorInput {
    func configure() -> LoginViewController
}

class LoginConfigurator: LoginConfiguratorInput {
    
    func configure() -> LoginViewController {
        guard let controller = Assembler.sharedAssembler.resolver.resolve(LoginViewController.self) else {
            return LoginViewController()
        }
        return controller
    }
}
