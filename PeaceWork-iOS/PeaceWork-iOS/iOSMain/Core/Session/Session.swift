//
//  Session.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/16/21.
//

import Foundation
import SwiftUI
import Combine
import FirebaseAuth

class Session: ObservableObject {
    @Inject private var auth: Auth
    var didChange = PassthroughSubject<Session, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    @Published var isLoggedIn = false
    @Published var option: LoginOption = .AuthController
    @AppStorage("isJobSeeker", store: .standard) var isJobSeeker: Bool = false
    @AppStorage("fullname", store: .standard) var fullname: String = ""
    @AppStorage("email", store: .standard) var email: String = ""
    @AppStorage("password", store: .standard) var password: String = ""
    @AppStorage("phone", store: .standard) var phone: String = ""
    @AppStorage("company", store: .standard) var company: String = ""
    @AppStorage("currentPosition", store: .standard) var currentPosition: String = ""
    @AppStorage("dateStarted", store: .standard) var dateStarted: String = ""

    @Published var currentUser: PeaceWorkUser? {
        didSet {
            self.didChange.send(self)
        }
    }
    func listen(){
        handle = auth.addStateDidChangeListener({ [weak self] (auth, user) in
            if let user = user {
                self?.currentUser = PeaceWorkUser(email: user.email)
                self?.isLoggedIn = true
            } else {
                self?.isLoggedIn = false
                self?.currentUser = nil
            }
        })
    }

    func logOut(){
        self.currentUser = nil
        isLoggedIn = false
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing Out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
