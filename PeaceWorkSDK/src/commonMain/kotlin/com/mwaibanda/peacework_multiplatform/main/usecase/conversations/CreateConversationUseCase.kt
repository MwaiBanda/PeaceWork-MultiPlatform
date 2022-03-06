package com.mwaibanda.peacework_multiplatform.main.usecase.conversations

import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation
import com.mwaibanda.peacework_multiplatform.main.model.conversation.Participant
import com.mwaibanda.peacework_multiplatform.main.repository.ConversationRepository

class CreateConversationUseCase(
    private val conversationRepository: ConversationRepository
) {
    suspend operator fun invoke(participants: List<Participant>, onCompletion: (Conversation) -> Unit) {
        conversationRepository.createConversation(participants) {
            onCompletion(it)
        }
    }
}