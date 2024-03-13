//
//  RegisterConfiguration.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation
import Swinject

protocol RegisterConfiguratorInput {
    func configure() -> RegisterViewController
}

class RegisterConfigurator: RegisterViewController {
    
    func configure() -> RegisterViewController {
        guard let controller = Assembler.sharedAssembler.resolver.resolve(RegisterViewController.self) else {
            return RegisterViewController()
        }
        return controller
    }
}
