//
//  AddExpensesViewController.swift
//  expenses
//
//  Created by vcampus on 3/12/24.
//

import Foundation
import UIKit
import Combine

class AddExpensesViewController: BaseViewController {
    
    // MARK: VARIABLE
    var categories: [String]?
    var isEdit: Bool?
    var requestData: ExpensesListResponse?
    
    // MARK: OUTLET
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var titleErrorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var dateErrorLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTextfield: UITextField!
    @IBOutlet weak var amountErrorLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryTextfield: UITextField!
    @IBOutlet weak var categoryErrorLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet weak var locationErrorLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesTextfield: UITextField!
    @IBOutlet weak var notesErrorLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: DI
    var router: AddExpensesRouterInput?
    var addExpensesVM: AddExpensesViewModelDelegate?
    var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: false)
    }
    
    // MARK: LOCALIZE
    override func localizeUI() {
        let pageTitle = (isEdit ?? false) ? NSLocalizedString(Localized.add_expenses_view_controller_page_title_edit.rawValue, comment: "") : NSLocalizedString(Localized.add_expenses_view_controller_page_title_add.rawValue, comment: "")
        pageTitleLabel.text = pageTitle
        titleLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_title.rawValue, comment: "")
        titleTextfield.placeholder = NSLocalizedString(Localized.add_expenses_view_controller_title_hint.rawValue, comment: "")
        titleErrorLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_title_invalid.rawValue, comment: "")
        
        titleLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_title.rawValue, comment: "")
        titleTextfield.placeholder = NSLocalizedString(Localized.add_expenses_view_controller_title_hint.rawValue, comment: "")
        titleErrorLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_title_invalid.rawValue, comment: "")
        
        dateLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_date.rawValue, comment: "")
        dateTextfield.placeholder = NSLocalizedString(Localized.add_expenses_view_controller_date_hint.rawValue, comment: "")
        dateErrorLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_date_invalid.rawValue, comment: "")
        
        amountLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_amount.rawValue, comment: "")
        amountTextfield.placeholder = NSLocalizedString(Localized.add_expenses_view_controller_amount_hint.rawValue, comment: "")
        amountErrorLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_amount_invalid.rawValue, comment: "")
        
        categoryLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_category.rawValue, comment: "")
        categoryTextfield.placeholder = NSLocalizedString(Localized.add_expenses_view_controller_category_hint.rawValue, comment: "")
        categoryErrorLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_category_invalid.rawValue, comment: "")
        
        locationLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_location.rawValue, comment: "")
        locationTextfield.placeholder = NSLocalizedString(Localized.add_expenses_view_controller_location_hint.rawValue, comment: "")
        locationErrorLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_location_invalid.rawValue, comment: "")
        
        notesLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_notes.rawValue, comment: "")
        notesTextfield.placeholder = NSLocalizedString(Localized.add_expenses_view_controller_notes_hint.rawValue, comment: "")
        notesErrorLabel.text = NSLocalizedString(Localized.add_expenses_view_controller_notes_invalid.rawValue, comment: "")
        
        let buttonTitle = (isEdit ?? false) ? NSLocalizedString(Localized.add_expenses_view_controller_button_edit.rawValue, comment: "") : NSLocalizedString(Localized.add_expenses_view_controller_button_save.rawValue, comment: "")
        saveButton.setTitle(buttonTitle, for: .normal)
    }
    
    // MARK: SETUP VIEW
    override func setupView() {
        pageTitleLabel.font = Font(.installed(.RowdiesBold), size: .standard(.s20)).instance
        titleLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s12)).instance
        titleErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        titleErrorLabel.textColor = Palette.colorFF0000
        titleErrorLabel.isHidden = true
        dateLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s12)).instance
        dateErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        dateErrorLabel.textColor = Palette.colorFF0000
        dateErrorLabel.isHidden = true
        amountLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s12)).instance
        amountErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        amountErrorLabel.textColor = Palette.colorFF0000
        amountErrorLabel.isHidden = true
        categoryLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s12)).instance
        categoryErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        categoryErrorLabel.textColor = Palette.colorFF0000
        categoryErrorLabel.isHidden = true
        createCategoryPicker()
        locationLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s12)).instance
        locationErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        locationErrorLabel.textColor = Palette.colorFF0000
        locationErrorLabel.isHidden = true
        notesLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s12)).instance
        notesErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        notesErrorLabel.textColor = Palette.colorFF0000
        notesErrorLabel.isHidden = true
        saveButton.titleLabel?.font = Font(.installed(.RowdiesLight), size: .standard(.s20)).instance
        saveButton.backgroundColor = Palette.colorFCD303
        saveButton.setTitleColor(Palette.colorBLACK, for: .normal)
        
        if (isEdit ?? false) {
            showCurrentData()
        }
    }
    
    private func showCurrentData() {
        titleTextfield.text = requestData?.title
        dateTextfield.text = requestData?.date
        amountTextfield.text = "\(requestData?.amount ?? 0)"
        categoryTextfield.text = requestData?.category
        locationTextfield.text = requestData?.location
        notesTextfield.text = requestData?.notes
    }
    
    private func showInputDialog() {
        let alertController = UIAlertController(title: NSLocalizedString(Localized.add_expenses_view_controller_add_category_title.rawValue, comment: ""), message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = NSLocalizedString(Localized.add_expenses_view_controller_add_category_hint.rawValue, comment: "")
        }
        
        let okAction = UIAlertAction(title: NSLocalizedString(Localized.ok_string.rawValue, comment: ""), style: .default) { _ in
            if let textField = alertController.textFields?.first, let inputValue = textField.text {
                var requestData = CreateCategoryRequest()
                requestData.category = inputValue
                self.addExpensesVM?.createCategory(requestData: requestData)
            }
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString(Localized.cancel_string.rawValue, comment: ""), style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func createCategoryPicker() {
        let categoryPicker = UIPickerView()
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        
        categoryTextfield.inputView = categoryPicker
    }
    
    @objc func showCategoryOptions() {
        let alertController = UIAlertController(title: "Select Category", message: nil, preferredStyle: .actionSheet)
        
        for category in categories ?? [] {
            let action = UIAlertAction(title: category, style: .default) { [weak self] _ in
                // Xử lý khi người dùng chọn một category
                self?.categoryTextfield.text = category
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: ACTION
    override func actionHandler() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCategoryOptions))
        categoryTextfield.addGestureRecognizer(tapGesture)
        
        let addCategoryTap = UITapGestureRecognizer(target: self, action: #selector(didTapAddCategory))
        addImageView.isUserInteractionEnabled = true
        addImageView.addGestureRecognizer(addCategoryTap)
    }
    
    @IBAction func didTapModify(_ sender: Any) {
        titleErrorLabel.isHidden = true
        dateErrorLabel.isHidden = true
        amountErrorLabel.isHidden = true
        categoryErrorLabel.isHidden = true
        locationErrorLabel.isHidden = true
        notesErrorLabel.isHidden = true
        if !validateForm() {
            return
        }
        guard let title = titleTextfield.text, let date = dateTextfield.text,
              let amount = amountTextfield.text, let category = categoryTextfield.text,
        let location = locationTextfield.text, let notes = notesTextfield.text else { return }
        if (isEdit ?? false) {
            var updateData = UpdateExpensesRequest()
            updateData.title = title
            updateData.date = date
            updateData.amount = Int(amount)
            updateData.category = category
            updateData.location = location
            updateData.notes = notes
            addExpensesVM?.editExpenses(requestData: updateData, expensesId: "\(requestData?.id ?? 0)")
        } else {
            var newData = CreateExpensesRequest()
            newData.title = title
            newData.date = date
            newData.amount = Int(amount)
            newData.category = category
            newData.location = location
            newData.notes = notes
            addExpensesVM?.createExpenses(requestData: newData)
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        router?.goBack()
    }
    
    @objc func didTapAddCategory() {
        showInputDialog()
    }
    
    // MARK: DATA HANDLER
    override func bind() {
        addExpensesVM?.status.sink { [self] state in
            switch state {
            case .loading:
                //                showLoading()
                break
            case .createCategorySuccess:
                DispatchQueue.main.async {
                    self.displayMessage(message: "Add new category success")
                }
                break
            case .createExpensesSuccess:
                DispatchQueue.main.async {
                    self.displayMessage(message: "Add new category success")
                }
                break
            case .editExpensesSuccess:
                DispatchQueue.main.async {
                    self.displayMessage(message: "Edit expenses success")
                }
                break
            case .loadingFailureWithMessage:
                DispatchQueue.main.async {
                    self.displayMessage(message: "There was an error.")
                }
                break
            default:
                break
            }
        }.store(in: &subscriptions)
    }
    
    private func validateForm() -> Bool{
        var isValid = true;
        let customValidation = CustomValidation()
        if ((titleTextfield.text ?? "").isEmpty) {
            titleErrorLabel.isHidden = false
            isValid = false;
        }
        if ((dateTextfield.text ?? "").isEmpty) {
            dateErrorLabel.isHidden = false
            isValid = false;
        }
        if ((amountTextfield.text ?? "").isEmpty) {
            amountErrorLabel.isHidden = false
            isValid = false;
        }
        if ((categoryTextfield.text ?? "").isEmpty) {
            categoryErrorLabel.isHidden = false
            isValid = false;
        }
        if ((locationTextfield.text ?? "").isEmpty) {
            locationErrorLabel.isHidden = false
            isValid = false;
        }
        if ((notesTextfield.text ?? "").isEmpty) {
            notesErrorLabel.isHidden = false
            isValid = false;
        }
        return isValid
    }
}

// MARK: UIPickerViewDelegate && UIPickerViewDataSource
extension AddExpensesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        categoryTextfield.text = categories?[row]
    }
}

