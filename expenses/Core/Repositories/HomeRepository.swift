//
//  HomeRepository.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import Combine

protocol HomeRepositoryDelegate {
    var homeProvider: HomeProviderProtocol? { get }
    
    func fetchExpensesList(date: String, category: String) async throws -> [ExpensesListResponse]
    func createExpenses(requestData: CreateExpensesRequest) async throws -> String
    func editExpenses(requestData: UpdateExpensesRequest, expensesId: String) async throws -> String
    func deleteExpense(expensesId: String) async throws -> String
    func fetchCategories() async throws -> CategoriesResponse
    func createCategories(requestData: CreateCategoryRequest) async throws -> String
    func fetchStatistics() async throws -> StatisticsResponse
}

class HomeRepository: HomeRepositoryDelegate {
    
    var homeProvider: HomeProviderProtocol?
    
    func fetchExpensesList(date: String, category: String) async throws -> [ExpensesListResponse] {
        guard let data = try await homeProvider?.fetchExpensesList(date: date, category: category) else {
            throw CustomError.nilData
        }
        return data
    }
    
    func createExpenses(requestData: CreateExpensesRequest) async throws -> String {
        guard let data = try await homeProvider?.createExpenses(requestData: requestData) else {
            throw CustomError.nilData
        }
        return data["message"] ?? ""
    }
    
    func editExpenses(requestData: UpdateExpensesRequest, expensesId: String) async throws -> String {
        guard let data = try await homeProvider?.editExpenses(requestData: requestData, expensesId: expensesId) else {
            throw CustomError.nilData
        }
        return data["message"] ?? ""
    }
    
    func deleteExpense(expensesId: String) async throws -> String {
        guard let data = try await homeProvider?.deleteExpense(expensesId: expensesId) else {
            throw CustomError.nilData
        }
        return data["message"] ?? ""
    }
    
    func fetchCategories() async throws -> CategoriesResponse {
        guard let data = try await homeProvider?.fetchCategories() else {
            throw CustomError.nilData
        }
        return data
    }
    
    func createCategories(requestData: CreateCategoryRequest) async throws -> String {
        guard let data = try await homeProvider?.createCategories(requestData: requestData) else {
            throw CustomError.nilData
        }
        return data["message"] ?? ""
    }
    
    func fetchStatistics() async throws -> StatisticsResponse {
        guard let data = try await homeProvider?.fetchStatistics() else {
            throw CustomError.nilData
        }
        return data
    }
}
