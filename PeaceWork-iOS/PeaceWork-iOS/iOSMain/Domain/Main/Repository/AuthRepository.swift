//
//  AuthRepository.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/26/21.
//

import Foundation
import FirebaseAuth

protocol AuthRepository {
    func signInWithEmail(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    )
    func signupWithEmail(
        email: String,
        password: String,
        handler: @escaping AuthDataResultCallback
    )
    func signInAsGuest()
    func resetPasswordWithEmail(email: String)
}

