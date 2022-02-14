//
//  SignUpUseCase.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/27/21.
//

import Foundation
import FirebaseAuth

struct SignUpUseCase {
    @Inject private var authRepositoryImplementation: AuthRepositoryImplementation
    func execute(email: String, password: String, handler: @escaping AuthDataResultCallback){
        authRepositoryImplementation.signupWithEmail(email: email, password: password, handler: handler)
    }
    private init(){ }
    static var sharedInstance = SignUpUseCase()
}
