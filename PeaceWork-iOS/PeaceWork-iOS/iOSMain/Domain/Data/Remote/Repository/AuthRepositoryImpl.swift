//
//  AuthRepositoryImpl.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/26/21.
//


import Foundation
import FirebaseAuth

final class AuthRepositoryImplementation: AuthRepository {
    @Inject private var auth: Auth
    static let shardInstance = AuthRepositoryImplementation()
    
    func signInWithEmail(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    )  {
        auth.signIn(withEmail: email, password: password, completion: handler)
    }
    
    func signupWithEmail(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    ) {
        auth.createUser(withEmail: email, password: password, completion: handler)
    }
    
    func signInAsGuest() {
        
    }
    
    func resetPasswordWithEmail(email: String) {
        
    }
    
    private init(){ }
    
}



