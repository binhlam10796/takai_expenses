//
//  AddExpensesViewModelInOutDelegate.swift
//  expenses
//
//  Created by vcampus on 3/13/24.
//

import Foundation
import Combine

enum AddExpensesViewModelStatus {
    case none
    case loading
    case createExpensesSuccess
    case editExpensesSuccess
    case createCategorySuccess
    case loadingFailureWithMessage(message: String)
}

protocol AddExpensesViewModelInputDelegate {
    var homeUseCase: HomeUseCaseDelegate? { get }
    func createExpenses(requestData: CreateExpensesRequest)
    func editExpenses(requestData: UpdateExpensesRequest, expensesId: String)
    func createCategory(requestData: CreateCategoryRequest)
}

protocol AddExpensesViewModelOuputDelegate {
    var status: CurrentValueSubject<AddExpensesViewModelStatus, Never> { get set }
}
