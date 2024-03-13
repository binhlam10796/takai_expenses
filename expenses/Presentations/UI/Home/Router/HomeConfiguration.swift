//
//  HomeConfiguration.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import Swinject

protocol HomeConfiguratorInput {
    func configure() -> HomeViewController
}

class HomeConfigurator: HomeViewController {
    
    func configure() -> HomeViewController {
        guard let controller = Assembler.sharedAssembler.resolver.resolve(HomeViewController.self) else {
            return HomeViewController()
        }
        return controller
    }
}
