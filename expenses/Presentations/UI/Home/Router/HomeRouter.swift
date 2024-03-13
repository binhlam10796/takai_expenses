//
//  HomeRouter.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation

//MARK: - Protocol
protocol HomeRouterInput {
    var vc: HomeViewController! { get }
    
    func goBack()
    
    func navigateToAddExpensesView(isEdit: Bool, categories: [String], requestData: ExpensesListResponse?)
}

//MARK: - Implementation
class HomeRouter: HomeRouterInput {
    
    weak var vc: HomeViewController!
    
    init(vc: HomeViewController) {
        self.vc = vc
    }
    
    func goBack() {
        vc.navigationController?.popViewController(animated: true)
    }
    
    func navigateToAddExpensesView(isEdit: Bool, categories: [String], requestData: ExpensesListResponse?) {
        let addExpensesVC = AddExpensesConfigurator().configure()
        addExpensesVC.isEdit = isEdit
        addExpensesVC.categories = categories
        addExpensesVC.requestData = requestData
        vc.navigationController?.pushViewController(addExpensesVC, animated: true)
    }
}
