//
//  AuthService.swift
//  Mockup
//
//  Created by Vladislav Erchik on 7.12.20.
//

import Foundation
import FirebaseAuth
import Combine

enum AuthError: Error, LocalizedError {
    case noData
    
    var errorDescription: String? {
        switch self {
        case .noData: return "Empty data received"
        }
    }
}

class AuthService {
    static var shared = AuthService()
    
    private init() {}
    
    var isSignedIn: Bool {
        Auth.auth().currentUser != nil
    }
    
    func signIn(email: String, password: String) -> Future<User, Error> {
        .init { (promise: @escaping Future<User, Error>.Promise) in
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let result = result {
                    promise(.success(result.user))
                } else {
                    promise(.failure(error ?? AuthError.noData))
                }
            }
        }
    }
    
    func signUp(email: String, password: String) -> Future<User, Error> {
        .init { (promise: @escaping Future<User, Error>.Promise) in
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let result = result {
                    promise(.success(result.user))
                } else {
                    promise(.failure(error ?? AuthError.noData))
                }
            }
        }
    }
    
    func logout() -> Future<Bool, Error> {
        .init { (promise: @escaping Future<Bool, Error>.Promise) in
            do {
                try Auth.auth().signOut()
                promise(.success(true))
            } catch {
                promise(.failure(error))
            }
        }
    }
}
