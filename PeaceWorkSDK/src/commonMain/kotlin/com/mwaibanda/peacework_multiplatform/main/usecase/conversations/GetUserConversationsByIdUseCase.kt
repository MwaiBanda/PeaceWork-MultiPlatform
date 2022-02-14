package com.mwaibanda.peacework_multiplatform.main.usecase.conversations

import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation
import com.mwaibanda.peacework_multiplatform.main.repository.ConversationRepository

class GetUserConversationsByIdUseCase(
    private val conversationRepository: ConversationRepository
) {
    suspend operator fun invoke(id: String): List<Conversation> {
        return conversationRepository.getUserConversationsById(id)
    }
}