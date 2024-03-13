//
//  NetworkAssembly.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import Swinject

class NetworkAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(HomeProviderProtocol.self) { resolver in
            let request = HomeProvider()
            return request
        }.inObjectScope(.transient)
    }
}
