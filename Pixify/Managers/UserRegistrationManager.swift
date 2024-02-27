//
//  UserRegistrationManager.swift
//  Pixify
//
//  Created by Ani's Mac on 26.02.24.
//

import Foundation

final class UserRegistrationManager {
    // MARK: - Shared Instance
    static let shared = UserRegistrationManager()
    
    // MARK: - Private Init
    private init() {}
    
    // MARK: - Methods
    func isEmailRegistered(email: String) -> Bool {
        let registeredEmails = UserDefaults.standard.array(forKey: "registeredEmails") as? [String] ?? []
        return registeredEmails.contains(email)
    }
    
    func registerUser(email: String, password: String, age: String, completion: @escaping (Bool, String?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if self.isEmailRegistered(email: email) {
                DispatchQueue.main.async {
                    completion(false, "Email already exists")
                }
                return
            }
            sleep(2)
            
            var registeredEmails = UserDefaults.standard.array(forKey: "registeredEmails") as? [String] ?? []
            registeredEmails.append(email)
            UserDefaults.standard.set(registeredEmails, forKey: "registeredEmails")
            UserDefaults.standard.set(password, forKey: "registeredPassword")
            UserDefaults.standard.set(age, forKey: "registeredAge")
            
            DispatchQueue.main.async {
                completion(true, "User successfully registered.")
            }
        }
    }
}

