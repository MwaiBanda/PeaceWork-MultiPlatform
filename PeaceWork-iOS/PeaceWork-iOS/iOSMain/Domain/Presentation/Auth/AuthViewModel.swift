//
//  AuthViewModel.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/26/21.
//

import Foundation
import FirebaseAuth
import PeaceWorkSDK 

final class AuthViewModel: UserController, ObservableObject {
    @Inject private var signInWithEmailUseCase: SignInUseCase
    @Inject private var signUpWithEmailUseCase: SignUpUseCase
    @Inject private var auth: Auth
    override init() {
        super.init()
    }
    func signInWithEmail(email: String, password: String, onSuccess: @escaping (String) -> Void ) {
        signInWithEmailUseCase.execute(email: email, password: password) { res, err in
            if res != nil {
                let eMail = EmailAuthProvider.credential(withEmail: email, password:password)
                Auth.auth().currentUser?.reauthenticate(with: eMail, completion: {
                        (res, error) in
                    onSuccess(res?.user.email ?? "")
                    })
            }
        }
    }
    
    func signUpWithEmail(email: String, password: String, onSuccess: @escaping (String) -> Void ) {
        signUpWithEmailUseCase.execute(email: email, password: password) { res, err in
            if res != nil {
                onSuccess(res?.user.email ?? "")
            }
        }
    }
}
