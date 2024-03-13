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
    
    func sortExpensesByDate() {
        expensesList = expensesList?.sorted { (expense1, expense2) -> Bool in
            guard let date1String = expense1.date, let date2String = expense2.date else {
                return false
            }
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            if let date1 = dateFormatter.date(from: date1String), let date2 = dateFormatter.date(from: date2String) {
                return date1 > date2
            }
            
            return false
        }
        
        status.send(.expensesLoaded)
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
    
    func deleteExpenses(expensesId: String) {
        Task {
            do {
                guard let data = try await homeUseCase?.deleteExpense(expensesId: expensesId) else {
                    status.send(.loadingFailureWithMessage(message: ""))
                    return
                }
                
                status.send(.deletedExpenses)
                
            } catch(_) {
                status.send(.loadingFailureWithMessage(message: ""))
            }
        }
    }
}
