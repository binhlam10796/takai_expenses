//
//  UseCaseAssembly.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import Swinject


class UseCaseAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(HomeUseCaseDelegate.self) { resolver in
            let homeUseCase = HomeUseCase()
            guard let homeRepo = resolver.resolve(HomeRepositoryDelegate.self) else {
                fatalError("Assembler was unable to resolve HomeRepositoryDelegate")
            }
            homeUseCase.homeRepository = homeRepo
            return homeUseCase
        }.inObjectScope(.transient)
    }
}
