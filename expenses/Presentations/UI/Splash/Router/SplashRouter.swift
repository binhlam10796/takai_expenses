//
//  SplashRouter.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import UIKit

//MARK: - Protocol
protocol SplashRouterInput {
    func navigateToHomeView()
    func navigateToLoginView()
}

//MARK: - Implementation
class SplashRouter: SplashRouterInput {
    
    func navigateToHomeView() {
        LOGP("Navigate to home")
    }
    
    func navigateToLoginView() { 
        let navController = UINavigationController(rootViewController: LoginConfigurator().configure())
        navController.setNavigationBarHidden(false, animated: false)
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
