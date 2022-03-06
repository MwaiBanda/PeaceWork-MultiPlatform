//
//  LoungeViewModel.swift
//  PeaceWork-iOS
//
//  Created by Mwai Banda on 3/5/22.
//

import Foundation
import PeaceWorkSDK

final class LoungeViewModel: UserController, ObservableObject {
    @Published var profile: User? = nil
    @Published var contacts = [Contact]()
    override init() {
        super.init()
    }
    func fetchProfile(userID: String, onCompletion: @escaping (String) -> Void){
        getUserProfile(userID: userID) { [weak self] user in
            self?.profile = user
            self?.contacts = user.contacts
            onCompletion(userID)
        }
    }
}
