//
//  LoungeViewModel.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/1/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import PeaceWorkSDK

final class ConversationViewModel: ConversationController, ObservableObject {
    @Published var conversations = [Conversation]()
    override init() {
        super.init()
    }
  
    func fetchConversations(id: String) {
        getUserConversationsById(id: id){ conversations in
             self.conversations = conversations
        }
    }
    func joinConversation(participants: (firstUsername: String, firstUserID: String, SecondUsername: String, SecondUserID: String), onCompletion: @escaping () -> Void){
        createConversation(participants: [
            Participant(
                userId: participants.firstUserID,
                username: participants.firstUsername
            ),
            Participant(
                userId: participants.SecondUserID,
                username: participants.SecondUsername
            )
        ]
        ) { [self] in
            conversations.append($0)
            onCompletion()
        }
    }
}
