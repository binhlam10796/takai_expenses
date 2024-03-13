//
//  HomeViewModel.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import Combine

protocol HomeViewModelDelegate: HomeViewModelInputDelegate, HomeViewModelOuputDelegate {}

class HomeViewModel: HomeViewModelDelegate {
    
    var homeUseCase: HomeUseCaseDelegate?
    var status: CurrentValueSubject<HomeViewModelStatus, Never> = .init(.none)
    var expensesList: [ExpensesListResponse]?
    var categiries: CategoriesResponse?
    var statistics: StatisticsResponse?
    
    func fetchExpensesList(date: String, category: String) {
        Task {
            do {
                guard let data = try await homeUseCase?.fetchExpensesList(date: date, category: category) else {
                    status.send(.loadingFailureWithMessage(message: ""))
                    return
                }
                
                self.expensesList = data
                status.send(.expensesLoaded)
                
            } catch(_) {
                status.send(.loadingFailureWithMessage(message: ""))
            }
        }
    }
    
    func fetchCategories() {
        Task {
            do {
                guard let data = try await homeUseCase?.fetchCategories() else {
                    status.send(.loadingFailureWithMessage(message: ""))
                    return
                }
                
                self.categiries = data
                status.send(.categoriesLoaded)
                
            } catch(_) {
                status.send(.loadingFailureWithMessage(message: ""))
            }
        }
    }
    
    func fechStatistics() {
        Task {
            do {
                guard let data = try await homeUseCase?.fetchStatistics() else {
                    status.send(.loadingFailureWithMessage(message: ""))
                    return
                }
                
                self.statistics = data
                status.send(.statisticsLoaded)
                
            } catch(_) {
                status.send(.loadingFailureWithMessage(message: ""))
            }
        }
    }
}
