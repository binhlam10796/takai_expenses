//
//  SplashConfiguration.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import Swinject

protocol SplashConfiguratorInput {
    func configure() -> SplashViewController
}

class SplashConfigurator: SplashConfiguratorInput {
    
    func configure() -> SplashViewController {
        guard let controller = Assembler.sharedAssembler.resolver.resolve(SplashViewController.self) else {
            return SplashViewController()
        }
        return controller
    }
}
