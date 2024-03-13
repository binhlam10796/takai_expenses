//
//  HomeEndpoint.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation


enum HomeEndpoint: APIEndpoint {
    case fetchExpensesList(date: String, category: String)
    case createExpenses(requestData: CreateExpensesRequest)
    case editExpenses(requestData: UpdateExpensesRequest, expensesId: String)
    case deleteExpense(expensesId: String)
    case fetchCategories
    case createCategories(requestData: CreateCategoryRequest)
    case fetchStatistics
    
    var baseURL: URL {
        return URL(string: "https://v521q.wiremockapi.cloud/api/")!
    }
    
    var path: String {
        switch self {
        case .fetchExpensesList(_, let category):
            if (category.isEmpty) {
                return "expenses"
            } else {
                return "expenses/\(category)"
            }
        case .createExpenses:
            return "expenses"
        case .editExpenses(_, let expensesId):
            return "expenses/\(expensesId)"
        case .deleteExpense(let expensesId):
            return "expenses/\(expensesId)"
        case .fetchCategories, .createCategories:
            return "categories"
        case .fetchStatistics:
            return "statistics"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .fetchExpensesList, .fetchCategories, .fetchStatistics:
            return .get
        case .createExpenses, .createCategories:
            return .post
        case .editExpenses:
            return .put
        case .deleteExpense:
            return .delete
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: ParameterSwift? {
        switch self {
            
        case .createExpenses(let requestData):
            let parameters: ParameterSwift = [
                "title": requestData.title!,
                "date": requestData.date!,
                "amount": requestData.amount ?? 0.0,
                "category": requestData.category!,
                "location": requestData.location!,
                "notes": requestData.notes!
            ]
            return parameters
        case .editExpenses(let requestData, _):
            let parameters: ParameterSwift = [
                "title": requestData.title!,
                "date": requestData.date!,
                "amount": requestData.amount ?? 0.0,
                "category": requestData.category!,
                "location": requestData.location!,
                "notes": requestData.notes!
            ]
            return parameters
        case .createCategories(let requestData):
            let parameters: ParameterSwift = [
                "category": requestData.category!
            ]
            return parameters
        default:
            return nil
        }
    }
}
