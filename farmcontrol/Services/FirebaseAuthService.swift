//
//  FirebaseAuthService.swift
//  farmcontrol
//
//  Created by Oscar Escamilla on 28/06/24.
//

import Foundation
import Firebase


class FirebaseAuthService {
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func loginUser(email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    
    func registerUser(name: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(error)
                return
            }
            
            guard let uid = authResult?.user.uid else {
                completion(NSError(domain: "FirebaseService", code: -1, userInfo: [NSLocalizedDescriptionKey: "User ID not found"]))
                return
            }
            
            let user = User(id: uid, name: name, email: email)
            self.saveUser(user: user, completion: completion)
        }
    }
    
    private func saveUser(user: User, completion: @escaping (Error?) -> Void) {
        db.collection("users").document(user.id).setData([
            "name": user.name,
            "email": user.email,
            "isActive": user.isActive
        ]) { error in
            completion(error)
        }
    }
}
