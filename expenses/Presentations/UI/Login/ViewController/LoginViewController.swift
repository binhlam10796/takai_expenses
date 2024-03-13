//
//  LoginViewController.swift
//  expenses
//
//  Created by vcampus on 3/11/24.
//

import Foundation
import UIKit
import Combine

class LoginViewController: BaseViewController {
    
    // MARK: OUTLET
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerLabel: UILabel!
    @IBOutlet weak var forgetLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    // MARK: DI
    var router: LoginRouterInput?
    var loginVM: LoginViewModelDelegate?
    var subscriptions: Set<AnyCancellable> = .init()
    
    // MARK: LOCALIZE
    override func localizeUI() {
        titleLabel.text = NSLocalizedString(Localized.login_view_controller_title.rawValue, comment: "")
        emailLabel.text = NSLocalizedString(Localized.login_view_controller_email_title.rawValue, comment: "")
        passwordLabel.text = NSLocalizedString(Localized.login_view_controller_password_title.rawValue, comment: "")
        loginButton.setTitle(NSLocalizedString(Localized.login_view_controller_login_button.rawValue, comment: ""), for: .normal)
        forgetLabel.text = NSLocalizedString(Localized.login_view_controller_create_account.rawValue, comment: "")
        registerLabel.text = NSLocalizedString(Localized.login_view_controller_regiser.rawValue, comment: "")
        emailTextField.placeholder = NSLocalizedString(Localized.login_view_controller_email_hint.rawValue, comment: "")
        passwordTextField.placeholder = NSLocalizedString(Localized.login_view_controller_password_hint.rawValue, comment: "")
    }
    
    // MARK: SETUP VIEW
    override func setupView() {
        titleLabel.font = Font(.installed(.RowdiesBold), size: .standard(.s30)).instance
        emailLabel.font = Font(.installed(.OutfitMedium), size: .standard(.s15)).instance
        passwordLabel.font = Font(.installed(.OutfitMedium), size: .standard(.s15)).instance
        forgetLabel.font = Font(.installed(.OutfitRegular), size: .standard(.s12)).instance
        registerLabel.font = Font(.installed(.OutfitMedium), size: .standard(.s12)).instance
        registerLabel.textColor = Palette.color0D47A1
        loginButton.titleLabel?.font = Font(.installed(.RowdiesLight), size: .standard(.s20)).instance
        loginButton.backgroundColor = Palette.colorFCD303
        loginButton.setTitleColor(Palette.colorBLACK, for: .normal)
        emailErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        emailErrorLabel.textColor = Palette.colorFF0000
        emailErrorLabel.isHidden = true
        passwordErrorLabel.font = Font(.system, size: .standard(.s11)).instance
        passwordErrorLabel.textColor = Palette.colorFF0000
        passwordErrorLabel.isHidden = true
        emailTextField.keyboardType = .emailAddress
        passwordTextField.isSecureTextEntry = true
    }
    
    // MARK: ACTION
    override func actionHandler() {
        let registerTap = UITapGestureRecognizer(target: self, action: #selector(didTapRegister))
        registerLabel.isUserInteractionEnabled = true
        registerLabel.addGestureRecognizer(registerTap)
    }
    
    @objc func didTapRegister() {
        router?.navigateToRegisterView()
    }
    
    @IBAction func didTapLogin(_ sender: Any) {
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        if !validateForm() {
            return
        }
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        loginVM?.login(email: email, password: password)
    }
    
    // MARK: DATA HANDLER
    override func bind() {
        loginVM?.status.sink { [self] state in
            switch state {
            case .loading:
                //                showLoading()
                break
            case .loginSuccess(let displayName):
                //                hideLoading()
                router?.navigateToHomeView(displayName: displayName, email: emailTextField.text ?? "")
                break
            case .loginFailure:
                //                hideLoading()
                displayMessage(message: "There was an error.")
                break
            case .loginFailureWithMessage(let message):
                //                hideLoading()
                handleAuthError(message)
                break
            default:
                break
            }
        }.store(in: &subscriptions)
    }
    
    private func handleAuthError(_ authError: FirebaseAuthManager.AuthError) {
        switch authError {
        case .invalidEmail, .emailAlreadyExists:
            emailErrorLabel.isHidden = false
            emailErrorLabel.text = authError.localizedDescription
        case .unknownError:
            displayMessage(message: authError.localizedDescription)
        case .wrongPassword:
            passwordErrorLabel.isHidden = false
            passwordErrorLabel.text = authError.localizedDescription
        }
    }
    
    private func validateForm() -> Bool{
        var isValid = true;
        let customValidation = CustomValidation()
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
