//
//  AddExpensesConfiguration.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import Swinject

protocol AddExpensesConfiguratorInput {
    func configure() -> AddExpensesViewController
}

class AddExpensesConfigurator: AddExpensesViewController {
    
    func configure() -> AddExpensesViewController {
        guard let controller = Assembler.sharedAssembler.resolver.resolve(AddExpensesViewController.self) else {
            return AddExpensesViewController()
        }
        return controller
    }
}
