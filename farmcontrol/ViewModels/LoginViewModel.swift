//
//  LoginViewModel.swift
//  farmcontrol
//
//  Created by Oscar Escamilla on 26/06/24.
//

import Foundation
import Firebase

class LoginViewModel {
    private let firebaseAuthService: FirebaseAuthService
    
    init(firebaseAuthService: FirebaseAuthService = FirebaseAuthService()) {
        self.firebaseAuthService = firebaseAuthService
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        firebaseAuthService.loginUser(email: email, password: password, completion: completion)
    }
    
    func registerUser(name: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        firebaseAuthService.registerUser(name: name, email: email, password: password, completion: completion)
    }
}
