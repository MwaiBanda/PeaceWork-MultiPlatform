//
//  LoungeViewModel.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/1/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import PeaceWorkSDK

class LoungeViewModel: ConversationController, ObservableObject {
    @Published var conversations = [Conversation]()

    override init() {
        super.init()
    }
    func fetchConversations(id: String) {
        getUserConversationsById(id: id) { [weak self] jobs, err in
                if err != nil {
                    print(err?.localizedDescription ?? "")
                } else {
                    self?.conversations = jobs ?? []
                }
            }
    }
}
