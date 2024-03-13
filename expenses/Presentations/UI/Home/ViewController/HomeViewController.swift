//
//  HomeViewController.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import UIKit
import Combine
import DGCharts

class HomeViewController: BaseViewController {
    
    // MARK: VARIABLE
    var displayName: String?
    var email: String?
    
    // MARK: OUTLET
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var pieChartView: PieChartView!
    @IBOutlet weak var expensesTableView: UITableView!
    @IBOutlet weak var addImageView: UIImageView!
    
    // MARK: DI
    var router: HomeRouterInput?
    var homeVM: HomeViewModelDelegate?
    var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: false)
    }
    
    // MARK: LOCALIZE
    override func localizeUI() {
        titleLabel.text = NSLocalizedString(Localized.home_view_controller_title.rawValue, comment: "")
        emailLabel.text = email ?? ""
        nameLabel.text = displayName ?? ""
    }
    
    // MARK: SETUP VIEW
    override func setupView() {
        titleLabel.font = Font(.installed(.RowdiesBold), size: .standard(.s20)).instance
        nameLabel.font = Font(.installed(.OutfitBold), size: .standard(.s15)).instance
        emailLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s13)).instance
        titleLabel.textColor = Palette.color0D47A1
        nameLabel.textColor = Palette.colorBLACK
        emailLabel.textColor = Palette.colorBLACK
        
        /// TABLE SECTION
        expensesTableView.separatorStyle = .none
        expensesTableView.register(UINib(nibName: ExpensesTableViewCell.XIB_NAME, bundle: nil), forCellReuseIdentifier: ExpensesTableViewCell.IDENTIFIER)
        expensesTableView.layoutIfNeeded()
        expensesTableView.dataSource = self
        expensesTableView.delegate = self
    }
    
    private func setupChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        for i in 0..<dataPoints.count {
            let dataEntry1 = ChartDataEntry(x: Double(i), y: values[i], data: dataPoints[i] as AnyObject)
            dataEntries.append(dataEntry1)
        }
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Categories")
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        pieChartView.data = pieChartData
        pieChartView.noDataText = "No data available"
        
        var colors: [UIColor] = []
        
        for _ in 0..<dataPoints.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        pieChartDataSet.colors = colors
    }
    
    // MARK: ACTION
    override func actionHandler() {
        let addTap = UITapGestureRecognizer(target: self, action: #selector(didTapAdd))
        addImageView.isUserInteractionEnabled = true
        addImageView.addGestureRecognizer(addTap)
    }
    
    @objc func didTapAdd() {
        router?.navigateToAddExpensesView(isEdit: false, categories: homeVM?.categiries?.categories ?? [], requestData: nil)
    }
    
    // MARK: DATA HANDLER
    override func bind() {
        homeVM?.fetchExpensesList(date: "", category: "")
        homeVM?.fetchCategories()
        homeVM?.fechStatistics()
        homeVM?.status.sink { [self] state in
            switch state {
            case .loading:
                //                showLoading()
                break
            case .expensesLoaded:
                DispatchQueue.main.async {
                    self.expensesTableView.reloadData()
                }
                break
            case .categoriesLoaded:
                break
            case .statisticsLoaded:
                DispatchQueue.main.sync {
                    guard let statistics = homeVM?.statistics?.data else { return }
                    let categories = Array(statistics.keys)
                    let amounts = Array(statistics.values)
                    setupChart(dataPoints: categories, values: amounts)
                }
                break
            case .loadingFailureWithMessage(let message):
                DispatchQueue.main.async {
                    self.displayMessage(message: message)
                }
                break
            default:
                break
            }
        }.store(in: &subscriptions)
    }
}

// MARK: UITABLEVIEW DELEGATE
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeVM?.expensesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = expensesTableView.dequeueReusableCell(withIdentifier: ExpensesTableViewCell.IDENTIFIER, for: indexPath) as? ExpensesTableViewCell {
            guard let viewModel = homeVM, let expenses = viewModel.expensesList?[indexPath.row] else {
                return UITableViewCell()
            }
            cell.setupExpensesRow(expenses)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = homeVM, let expenses = viewModel.expensesList?[indexPath.row] else {
            return
        }
        router?.navigateToAddExpensesView(isEdit: true, categories: viewModel.categiries?.categories ?? [], requestData: expenses)
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return ExpensesTableViewCell.DEFAULT_HEIGHT
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ExpensesTableViewCell.DEFAULT_HEIGHT
    }
}
