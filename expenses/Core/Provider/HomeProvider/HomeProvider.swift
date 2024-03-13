//
//  HomeProvider.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation

protocol HomeProviderProtocol {
    
    func fetchExpensesList(date: String, category: String) async throws -> [ExpensesListResponse]
    func createExpenses(requestData: CreateExpensesRequest) async throws -> [String: String]
    func editExpenses(requestData: UpdateExpensesRequest, expensesId: String) async throws -> [String: String]
    func deleteExpense(expensesId: String) async throws -> [String: String]
    func fetchCategories() async throws -> CategoriesResponse
    func createCategories(requestData: CreateCategoryRequest) async throws -> [String: String]
    func fetchStatistics() async throws -> StatisticsResponse
}

class HomeProvider: HomeProviderProtocol {
    
    func fetchExpensesList(date: String, category: String) async throws -> [ExpensesListResponse] {
        let endpoint = HomeEndpoint.fetchExpensesList(date: date, category: category)
        return try await URLSessionAPIClient.request(endpoint: endpoint, responseDTO: [ExpensesListResponse].self)
    }
    
    func createExpenses(requestData: CreateExpensesRequest) async throws -> [String: String] {
        let endpoint = HomeEndpoint.createExpenses(requestData: requestData)
        return try await URLSessionAPIClient.request(endpoint: endpoint, responseDTO: [String: String].self)
    }
    
    func editExpenses(requestData: UpdateExpensesRequest, expensesId: String) async throws -> [String: String] {
        let endpoint = HomeEndpoint.editExpenses(requestData: requestData, expensesId: expensesId)
        return try await URLSessionAPIClient.request(endpoint: endpoint, responseDTO: [String: String].self)
    }
    
    func deleteExpense(expensesId: String) async throws -> [String: String] {
        let endpoint = HomeEndpoint.deleteExpense(expensesId: expensesId)
        return try await URLSessionAPIClient.request(endpoint: endpoint, responseDTO: [String: String].self)
    }
    
    func fetchCategories() async throws -> CategoriesResponse {
        let endpoint = HomeEndpoint.fetchCategories
        return try await URLSessionAPIClient.request(endpoint: endpoint, responseDTO: CategoriesResponse.self)
    }
    
    func createCategories(requestData: CreateCategoryRequest) async throws -> [String: String] {
        let endpoint = HomeEndpoint.createCategories(requestData: requestData)
        return try await URLSessionAPIClient.request(endpoint: endpoint, responseDTO: [String: String].self)
    }
    
    func fetchStatistics() async throws -> StatisticsResponse {
        let endpoint = HomeEndpoint.fetchStatistics
        return try await URLSessionAPIClient.request(endpoint: endpoint, responseDTO: StatisticsResponse.self)
    }
}
