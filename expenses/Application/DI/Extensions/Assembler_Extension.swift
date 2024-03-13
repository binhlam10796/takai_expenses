//
//  Assembler_Extension.swift
//  expenses
//
//  Created by vcampus on 3/10/24.
//

import Foundation
import Swinject

extension Assembler {
    
    static var type: AssemblerType = .Default
    
    static let sharedAssembler: Assembler = {
        let container = Container()
        
        let assembler = Assembler([
            ViewControllerAssembly(),
            ViewModelAssembly(),
            RepositoryAssembly(),
            UseCaseAssembly(),
            NetworkAssembly(),
        ], container: container)
        
        return assembler
    }()
}

enum AssemblerType {
    case Default
    case Test
}
