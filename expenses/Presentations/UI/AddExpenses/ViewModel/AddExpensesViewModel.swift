//
//  AddExpensesViewModel.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import Combine

protocol AddExpensesViewModelDelegate: AddExpensesViewModelInputDelegate, AddExpensesViewModelOuputDelegate {}

class AddExpensesViewModel: AddExpensesViewModelDelegate {
    
    var homeUseCase: HomeUseCaseDelegate?
    var status: CurrentValueSubject<AddExpensesViewModelStatus, Never> = .init(.none)
    
    func createExpenses(requestData: CreateExpensesRequest) {
        Task {
            do {
                guard let data = try await homeUseCase?.createExpenses(requestData: requestData) else {
                    status.send(.loadingFailureWithMessage(message: ""))
                    return
                }
                
                status.send(.createCategorySuccess)
                
            } catch(_) {
                status.send(.loadingFailureWithMessage(message: ""))
            }
        }
    }
    
    func editExpenses(requestData: UpdateExpensesRequest, expensesId: String) {
        Task {
            do {
                guard let data = try await homeUseCase?.editExpenses(requestData: requestData, expensesId: expensesId) else {
                    status.send(.loadingFailureWithMessage(message: ""))
                    return
                }
                
                status.send(.editExpensesSuccess)
                
            } catch(_) {
                status.send(.loadingFailureWithMessage(message: ""))
            }
        }
    }
    
    func createCategory(requestData: CreateCategoryRequest) {
        Task {
            do {
                guard let data = try await homeUseCase?.createCategories(requestData: requestData) else {
                    status.send(.loadingFailureWithMessage(message: ""))
                    return
                }
                
                status.send(.createCategorySuccess)
                
            } catch(_) {
                status.send(.loadingFailureWithMessage(message: ""))
            }
        }
    }
}
