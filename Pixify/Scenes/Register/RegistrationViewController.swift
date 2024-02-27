//
//  RegistrationViewController.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import UIKit

final class RegistrationViewController: UIViewController {
    // MARK: - Methods
    private let viewModel = RegistrationViewModel()
    private let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
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
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = .customTextColor
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, ageTextField])
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
    
    private lazy var ageTextField: UITextField = {
        let textField = CustomTextField()
        textField.configure(
            placeholder: "DD/MM/YYYY",
            keyboardType: .default,
            icon: UIImage(systemName: "calendar"),
            isSecure: false)
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputView = pickerView
        textField.delegate = self
        return textField
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [SignUpButton, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var SignUpButton: MainButtonComponent = {
        let button = MainButtonComponent(text: "Sign Up")
        button.addTarget(self, action: #selector(signUpButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: SecondaryButtonComponent = {
        let button = SecondaryButtonComponent(text: "Log In")
        button.addTarget(self, action: #selector(loginButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Private Methods
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
        mainStackView.addArrangedSubview(signUpLabel)
        mainStackView.addArrangedSubview(textFieldsStackView)
        mainStackView.addArrangedSubview(buttonsStackView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
            ageTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    private func validateInputFields() -> Bool {
        let errors = viewModel.validateFields(email: emailTextField.text, password: passwordTextField.text, age: ageTextField.text)
        
        (emailTextField as? CustomTextField)?.setErrorState(false)
        (passwordTextField as? CustomTextField)?.setErrorState(false)
        (ageTextField as? CustomTextField)?.setErrorState(false)
        
        if let emailError = errors["email"] {
            (emailTextField as? CustomTextField)?.setErrorState(true, withMessage: emailError)
        }
        
        if let passwordError = errors["password"] {
            (passwordTextField as? CustomTextField)?.setErrorState(true, withMessage: passwordError)
        }
        
        if let ageError = errors["age"] {
            (ageTextField as? CustomTextField)?.setErrorState(true, withMessage: ageError)
        }
        return errors.isEmpty
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true)
    }
    
    //MARK: - Actions
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func signUpButtonDidTap() {
        guard validateInputFields() else { return }
        viewModel.registerUser(email: emailTextField.text ?? "",
                               password: passwordTextField.text ?? "",
                               age: ageTextField.text ?? ""
        ) { [weak self] success, message in
            DispatchQueue.main.async {
                if success {
                    let homeViewController = HomeViewController()
                    self?.navigationController?.pushViewController(homeViewController, animated: true)
                } else if message == "Email already exists" {
                    self?.showAlert(title: "Registration Failed", message: "The email address is already in use. Please try another email.")
                } else {
                    self?.showAlert(title: "Registration Failed", message: message )
                }
            }
        }
    }
    
    @objc private func loginButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Extension: UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        false
    }
}

// MARK: - Extension: UIPickerViewDataSource
extension RegistrationViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return 31
        case 1:
            return months.count
        case 2:
            return 99 - 18 + 1
        default:
            return 0
        }
    }
}

// MARK: - Extension: UIPickerViewDelegate
extension RegistrationViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(format: "%02d", row + 1)
        case 1:
            return months[row]
        case 2:
            let currentYear = Calendar.current.component(.year, from: Date())
            let year = currentYear - 18 - row
            return "\(year)"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let dayRow = pickerView.selectedRow(inComponent: 0)
        let monthRow = pickerView.selectedRow(inComponent: 1)
        let yearRow = pickerView.selectedRow(inComponent: 2)
        
        let day = String(format: "%02d", dayRow + 1)
        let month = months[monthRow]
        let currentYear = Calendar.current.component(.year, from: Date())
        let year = currentYear - 18 - yearRow
        
        ageTextField.text = "\(day)/\(month)/\(year)"
    }
}
