//
//  HomeViewModelInOutDelegate.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import Combine

enum HomeViewModelStatus {
    case none
    case loading
    case expensesLoaded
    case categoriesLoaded
    case statisticsLoaded
    case deletedExpenses
    case loadingFailureWithMessage(message: String)
}

protocol HomeViewModelInputDelegate {
    var homeUseCase: HomeUseCaseDelegate? { get }
    func fetchExpensesList(date: String, category: String)
    func fetchCategories()
    func fechStatistics()
    func deleteExpenses(expensesId: String)
    func sortExpensesByDate()
}

protocol HomeViewModelOuputDelegate {
    var status: CurrentValueSubject<HomeViewModelStatus, Never> { get set }
    var expensesList: [ExpensesListResponse]? { get set }
    var categiries: CategoriesResponse? { get set }
    var statistics: StatisticsResponse? { get set }
}
