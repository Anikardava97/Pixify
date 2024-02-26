//
//  RegistrationViewModel.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import Foundation

final class RegistrationViewModel {
    // MARK: - Methods
    func validateFields(email: String?, password: String?, age: String?) -> [String: String] {
        var errors: [String: String] = [:]
        
        if let email, email.isEmpty {
            errors["email"] = "Email field cannot be empty"
        } else if let email, !validateEmail(email) {
            errors["email"] = "Invalid email format"
        }
        
        if let password, password.isEmpty {
            errors["password"] = "Password field cannot be empty"
        } else if let password, !validatePassword(password) {
            errors["password"] = "Password must contain 6-12 characters"
        }
        
        if let age, age.isEmpty {
            errors["age"] = "Age field cannot be empty"
        }
        return errors
    }
    
    func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) -> Bool {
        return password.count >= 6 && password.count <= 12
    }
}

