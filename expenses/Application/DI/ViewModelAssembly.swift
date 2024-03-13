//
//  ViewModelAssembly.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    
    func assemble(container: Container) {
        
        // Login view model
        container.register(LoginViewModelDelegate.self) { resolver in
            let loginVM = LoginViewModel()
            let fam = FirebaseAuthManager()
            loginVM.fam = fam
            return loginVM
        }.inObjectScope(.transient)
        
        // Login view model
        container.register(RegisterViewModelDelegate.self) { resolver in
            let registerVM = RegisterViewModel()
            let fam = FirebaseAuthManager()
            registerVM.fam = fam
            return registerVM
        }.inObjectScope(.transient)
        
        // Home view model
        container.register(HomeViewModelDelegate.self) { resolver in
            let homeVM = HomeViewModel()
            guard let homeUseCase = resolver.resolve(HomeUseCaseDelegate.self) else {
                fatalError("Assembler was unable to resolve HomeUseCaseDelegate")
            }
            
            homeVM.homeUseCase = homeUseCase
            return homeVM
        }.inObjectScope(.transient)
        
        // Add expenses view model
        container.register(AddExpensesViewModelDelegate.self) { resolver in
            let addExpensesVM = AddExpensesViewModel()
            guard let homeUseCase = resolver.resolve(HomeUseCaseDelegate.self) else {
                fatalError("Assembler was unable to resolve HomeUseCaseDelegate")
            }
            
            addExpensesVM.homeUseCase = homeUseCase
            return addExpensesVM
        }.inObjectScope(.transient)
    }
    
}
