//
//  ViewControllerAssembly.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import Swinject

class ViewControllerAssembly: Assembly {
    
    enum ViewControllerIds: String {
        case SplashVC
        case LoginVC
        case HomeVC
        case RegisterVC
        case AddExpensesVC
    }
    
    enum ViewControllerStoryboards: String {
        case Splash
        case Login
        case Home
        case Register
        case AddExpenses
    }
    
    func assemble(container: Container) {
        
        // Splash view controller initialization
        container.register(SplashViewController.self) { r in
            guard let controller: SplashViewController = UIStoryboard(name: ViewControllerStoryboards.Splash.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewControllerIds.SplashVC.rawValue) as? SplashViewController else {
                fatalError("Assembler was unable to resolve SplashViewController")
            }
            controller.router = SplashRouter()
            
            return controller
        }.inObjectScope(.transient)
        
        // Login view controller initialization
        container.register(LoginViewController.self) { r in
            guard let controller: LoginViewController = UIStoryboard(name: ViewControllerStoryboards.Login.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewControllerIds.LoginVC.rawValue) as? LoginViewController else {
                fatalError("Assembler was unable to resolve LoginViewController")
            }
            guard let loginVM = r.resolve(LoginViewModelDelegate.self) else {
                fatalError("Assembler was unable to resolve LoginViewModelDelegate")
            }
            controller.loginVM = loginVM
            controller.router = LoginRouter(vc: controller)
            
            return controller
        }.inObjectScope(.transient)
        
        // Register view controller initialization
        container.register(RegisterViewController.self) { r in
            guard let controller: RegisterViewController = UIStoryboard(name: ViewControllerStoryboards.Register.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewControllerIds.RegisterVC.rawValue) as? RegisterViewController else {
                fatalError("Assembler was unable to resolve RegisterViewController")
            }
            guard let registerVM = r.resolve(RegisterViewModelDelegate.self) else {
                fatalError("Assembler was unable to resolve RegisterViewModelDelegate")
            }
            controller.registerVM = registerVM
            controller.router = RegisterRouter(vc: controller)
            
            return controller
        }.inObjectScope(.transient)
        
        // Home view controller initialization
        container.register(HomeViewController.self) { r in
            guard let controller: HomeViewController = UIStoryboard(name: ViewControllerStoryboards.Home.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewControllerIds.HomeVC.rawValue) as? HomeViewController else {
                fatalError("Assembler was unable to resolve HomeViewController")
            }
            guard let homeVM = r.resolve(HomeViewModelDelegate.self) else {
                fatalError("Assembler was unable to resolve HomeViewModelDelegate")
            }
            controller.homeVM = homeVM
            controller.router = HomeRouter(vc: controller)
            
            return controller
        }.inObjectScope(.transient)
        
        // Add expenses view controller initialization
        container.register(AddExpensesViewController.self) { r in
            guard let controller: AddExpensesViewController = UIStoryboard(name: ViewControllerStoryboards.AddExpenses.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewControllerIds.AddExpensesVC.rawValue) as? AddExpensesViewController else {
                fatalError("Assembler was unable to resolve AddExpensesViewController")
            }
            guard let addExpensesVM = r.resolve(AddExpensesViewModelDelegate.self) else {
                fatalError("Assembler was unable to resolve AddExpensesViewModelDelegate")
            }
            controller.addExpensesVM = addExpensesVM
            controller.router = AddExpensesRouter(vc: controller)
            
            return controller
        }.inObjectScope(.transient)
    }
}
