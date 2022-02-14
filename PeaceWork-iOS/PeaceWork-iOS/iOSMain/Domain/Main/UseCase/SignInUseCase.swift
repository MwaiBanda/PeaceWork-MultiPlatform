//
//  SignInUseCase.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/26/21.
//

import Foundation
import FirebaseAuth

struct SignInUseCase {
    @Inject private var authRepositoryImplementation: AuthRepositoryImplementation
    func execute(email: String, password: String, handler: @escaping AuthDataResultCallback){
        authRepositoryImplementation.signInWithEmail(email: email, password: password, handler: handler)
    }
    private init(){ }
    static var sharedInstance = SignInUseCase()
}
