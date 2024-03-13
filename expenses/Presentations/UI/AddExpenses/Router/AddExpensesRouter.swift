//
//  AddExpensesRouter.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation

//MARK: - Protocol
protocol AddExpensesRouterInput {
    var vc: AddExpensesViewController! { get }
    
    func goBack()
}

//MARK: - Implementation
class AddExpensesRouter: AddExpensesRouterInput {
    
    weak var vc: AddExpensesViewController!
    
    init(vc: AddExpensesViewController) {
        self.vc = vc
    }
    
    func goBack() {
        vc.navigationController?.popViewController(animated: true)
    }
}
