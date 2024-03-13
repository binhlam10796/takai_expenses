//
//  RepositoryAssembly.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import Swinject

class RepositoryAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(HomeRepositoryDelegate.self) { resolver in
            let homeRepo = HomeRepository()
            
            guard let homeProvider = resolver.resolve(HomeProviderProtocol.self) else {
                fatalError("Assembler was unable to resolve HomeProviderProtocol")
            }
            homeRepo.homeProvider = homeProvider
            
            return homeRepo
        }.inObjectScope(.transient)
    }
}
