//
//  LoginViewModel.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import Foundation

final class LoginViewModel {
    // MARK: - Methods
    func loginUser(email: String, password: String, completion: @escaping (Bool, String) -> Void) {
        let storedEmail = UserDefaults.standard.string(forKey: "registeredEmail")
        let storedPassword = UserDefaults.standard.string(forKey: "registeredPassword")
        
        if email == storedEmail && password == storedPassword {
            completion(true, "Login successful.")
        } else {
            completion(false, "Email or password is not correct")
        }
    }
    
    func validateFields(email: String?, password: String?) -> [String: String] {
        var errors: [String: String] = [:]
        
        if let email = email, email.isEmpty {
            errors["email"] = "Email field cannot be empty"
        } else if let email = email, !validateEmail(email) {
            errors["email"] = "Invalid email format"
        }
        
        if let password = password, password.isEmpty {
            errors["password"] = "Password field cannot be empty"
        } else if let password = password, !validatePassword(password) {
            errors["password"] = "Password must contain 6-12 characters"
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
