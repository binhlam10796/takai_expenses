//
//  HomeUseCase.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import Foundation

protocol HomeUseCaseDelegate {
    var homeRepository: HomeRepositoryDelegate? { get }
    
    func fetchExpensesList(date: String, category: String) async throws -> [ExpensesListResponse]
    func createExpenses(requestData: CreateExpensesRequest) async throws -> String
    func editExpenses(requestData: UpdateExpensesRequest, expensesId: String) async throws -> String
    func deleteExpense(expensesId: String) async throws -> String
    func fetchCategories() async throws -> CategoriesResponse
    func createCategories(requestData: CreateCategoryRequest) async throws -> String
    func fetchStatistics() async throws -> StatisticsResponse
}

class HomeUseCase: HomeUseCaseDelegate {
    
    var homeRepository: HomeRepositoryDelegate?
    
    func fetchExpensesList(date: String, category: String) async throws -> [ExpensesListResponse] {
        guard let data = try await homeRepository?.fetchExpensesList(date: date, category: category) else {
            throw CustomError.nilData
        }
        return data
    }
    
    func createExpenses(requestData: CreateExpensesRequest) async throws -> String {
        guard let data = try await homeRepository?.createExpenses(requestData: requestData) else {
            throw CustomError.nilData
        }
        return data
    }
    
    func editExpenses(requestData: UpdateExpensesRequest, expensesId: String) async throws -> String {
        guard let data = try await homeRepository?.editExpenses(requestData: requestData, expensesId: expensesId) else {
            throw CustomError.nilData
        }
        return data
    }
    
    func deleteExpense(expensesId: String) async throws -> String {
        guard let data = try await homeRepository?.deleteExpense(expensesId: expensesId) else {
            throw CustomError.nilData
        }
        return data
    }
    
    func fetchCategories() async throws -> CategoriesResponse {
        guard let data = try await homeRepository?.fetchCategories() else {
            throw CustomError.nilData
        }
        return data
    }
    
    func createCategories(requestData: CreateCategoryRequest) async throws -> String {
        guard let data = try await homeRepository?.createCategories(requestData: requestData) else {
            throw CustomError.nilData
        }
        return data
    }
    
    func fetchStatistics() async throws -> StatisticsResponse {
        guard let data = try await homeRepository?.fetchStatistics() else {
            throw CustomError.nilData
        }
        return data
    }
}
