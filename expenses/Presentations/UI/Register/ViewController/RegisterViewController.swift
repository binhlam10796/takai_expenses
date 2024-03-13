//
//  RegisterViewController.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation
import UIKit
import Combine

class RegisterViewController: BaseViewController {
    
    // MARK: OUTLET
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var haveAccountLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    // MARK: LIFE CYCLE
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: false)
    }
    
    // MARK: DI
    var router: RegisterRouterInput?
    var registerVM: RegisterViewModelDelegate?
    var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: LOCALIZE
    override func localizeUI() {
        titleLabel.text = NSLocalizedString(Localized.register_view_controller_title.rawValue, comment: "")
        nameLabel.text = NSLocalizedString(Localized.register_view_controller_name_title.rawValue, comment: "")
        emailLabel.text = NSLocalizedString(Localized.register_view_controller_email_title.rawValue, comment: "")
        passwordLabel.text = NSLocalizedString(Localized.register_view_controller_password_title.rawValue, comment: "")
        registerButton.setTitle(NSLocalizedString(Localized.register_view_controller_register_button.rawValue, comment: ""), for: .normal)
        haveAccountLabel.text = NSLocalizedString(Localized.register_view_controller_have_account.rawValue, comment: "")
        loginLabel.text = NSLocalizedString(Localized.register_view_controller_login.rawValue, comment: "")
        nameTextfield.placeholder = NSLocalizedString(Localized.register_view_controller_name_hint.rawValue, comment: "")
        emailTextField.placeholder = NSLocalizedString(Localized.register_view_controller_email_hint.rawValue, comment: "")
        passwordTextField.placeholder = NSLocalizedString(Localized.register_view_controller_password_hint.rawValue, comment: "")
    }
    
    // MARK: SETUP VIEW
    override func setupView() {
        titleLabel.font = Font(.installed(.RowdiesBold), size: .standard(.s30)).instance
        nameLabel.font = Font(.installed(.OutfitMedium), size: .standard(.s15)).instance
        emailLabel.font = Font(.installed(.OutfitMedium), size: .standard(.s15)).instance
        passwordLabel.font = Font(.installed(.OutfitMedium), size: .standard(.s15)).instance
        haveAccountLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s12)).instance
        loginLabel.font = Font(.installed(.OutfitMedium), size: .standard(.s12)).instance
        loginLabel.textColor = Palette.color0D47A1
        nameErrorLabel.textColor = Palette.colorFF0000
        nameErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        nameErrorLabel.isHidden = true
        emailErrorLabel.textColor = Palette.colorFF0000
        emailErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        emailErrorLabel.isHidden = true
        passwordErrorLabel.textColor = Palette.colorFF0000
        passwordErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        passwordErrorLabel.isHidden = true
        registerButton.titleLabel?.font = Font(.installed(.RowdiesBold), size: .standard(.s20)).instance
        registerButton.backgroundColor = Palette.colorFCD303
        registerButton.setTitleColor(Palette.colorBLACK, for: .normal)
        emailTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
    }
    
    // MARK: ACTION
    override func actionHandler() {
        let loginTap = UITapGestureRecognizer(target: self, action: #selector(didTapLogin))
        loginLabel.isUserInteractionEnabled = true
        loginLabel.addGestureRecognizer(loginTap)
    }
    
    @objc func didTapLogin() {
        router?.goBack()
    }
    
    @IBAction func didTapRegister(_ sender: Any) {
        nameErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        if !validateForm() {
            return
        }
        guard let email = emailTextField.text, let password = passwordTextField.text, let displayName = nameTextfield.text else { return }
        registerVM?.register(email: email, password: password, displayName: displayName)
    }
    
    // MARK: DATA HANDLER
    override func bind() {
        registerVM?.status.sink { [self] state in
            switch state {
            case .loading:
                showLoading()
                break
            case .registerSuccess:
                hideLoading()
                self.router?.goBack()
                break
            case .registerFailure:
                hideLoading()
                self.displayMessage(message: "There was an error.")
                break
            case .registerFailureWithMessage(let message):
                hideLoading()
                handleAuthError(message)
            default:
                break
            }
        }.store(in: &subscriptions)
    }
    
    private func handleAuthError(_ authError: FirebaseAuthManager.AuthError) {
        switch authError {
        case .invalidEmail:
            emailErrorLabel.isHidden = false
            emailErrorLabel.text = authError.localizedDescription
            break
        case .emailAlreadyExists:
            emailErrorLabel.isHidden = false
            emailErrorLabel.text = authError.localizedDescription
            break
        case .unknownError:
            displayMessage(message: authError.localizedDescription)
            break
        case .wrongPassword:
            passwordErrorLabel.isHidden = false
            passwordErrorLabel.text = authError.localizedDescription
            break
        }
    }
    
    private func validateForm() -> Bool{
        var isValid = true;
        let customValidation = CustomValidation()
        if ((nameTextfield.text ?? "").isEmpty) {
            nameErrorLabel.isHidden = false
            nameErrorLabel.text = NSLocalizedString(Localized.register_view_controller_name_invalid.rawValue, comment: "")
            isValid = false;
        }
        if (!customValidation.isValidEmail(email: emailTextField.text ?? "")) {
            emailErrorLabel.isHidden = false
            emailErrorLabel.text = NSLocalizedString(Localized.register_view_controller_email_invalid.rawValue, comment: "")
            isValid = false;
        }
        if (!customValidation.isValidPassword(password: passwordTextField.text ?? "")) {
            passwordErrorLabel.isHidden = false
            passwordErrorLabel.text = NSLocalizedString(Localized.register_view_controller_password_invalid.rawValue, comment: "")
            isValid = false;
        }
        return isValid
    }
}
