//
//  LoginViewController.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import UIKit

final class LoginViewController: UIViewController {
    // MARK: - Methods
    private let viewModel = LoginViewModel()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: .authenticationBackground)
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 0.2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome back"
        label.textColor = .customTextColor
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 28
        return stackView
    }()
    
    private let emailTextField: UITextField = {
        let textField = CustomTextField()
        textField.configure(
            placeholder: "test@gmail.com",
            keyboardType: .default,
            icon: UIImage(systemName: "envelope.fill"),
            isSecure: false)
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = CustomTextField()
        textField.configure(
            placeholder: "********",
            keyboardType: .default,
            icon: UIImage(systemName: "lock.fill"),
            isSecure: true)
        return textField
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginButton, SignUpButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var loginButton: MainButtonComponent = {
        let button = MainButtonComponent(text: "Log In")
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var SignUpButton: SecondaryButtonComponent = {
        let button = SecondaryButtonComponent(text: "Sign Up")
        button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideBackButton()
        setup()
    }
    
    // MARK: - Private Methods
    private func hideBackButton() {
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func setup() {
        setupBackground()
        setupSubviews()
        setupConstraints()
        setupTapGesture()
    }
    
    private func setupBackground() {
        view.backgroundColor = .customBackgroundColor
    }
    
    private func setupSubviews() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainStackView)
        mainStackView.addArrangedSubview(loginLabel)
        mainStackView.addArrangedSubview(textFieldsStackView)
        mainStackView.addArrangedSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func validateInputFields() -> Bool {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return false
        }
        
        let errors = viewModel.validateFields(email: email, password: password)
        
        (emailTextField as? CustomTextField)?.setErrorState(false)
        (passwordTextField as? CustomTextField)?.setErrorState(false)
        
        var isValid = true
        
        if let emailError = errors["email"] {
            (emailTextField as? CustomTextField)?.setErrorState(true, withMessage: emailError)
            isValid = false
        }
        
        if let passwordError = errors["password"] {
            (passwordTextField as? CustomTextField)?.setErrorState(true, withMessage: passwordError)
            isValid = false
        }
        return isValid
    }
    
    private func showAlert(message: String) {
        let alertController = UIAlertController(title: "Login Failed", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    //MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func loginButtonDidTap() {
        guard validateInputFields() else { return }
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        viewModel.loginUser(email: email, password: password) { [weak self] success, message in
            DispatchQueue.main.async {
                if success {
                    let homeViewController = HomeViewController()
                    self?.navigationController?.pushViewController(homeViewController, animated: true)
                } else {
                    self?.showAlert(message: message)
                }
            }
        }
    }
    
    @objc private func signUpButtonDidTap() {
        let backButton = UIBarButtonItem()
        backButton.title = "Log In"
        navigationItem.backBarButtonItem = backButton
        let signUpViewController = RegistrationViewController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
}
