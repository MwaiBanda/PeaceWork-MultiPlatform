package com.mwaibanda.peacework_multiplatform.main.usecase.messaging

import com.mwaibanda.peacework_multiplatform.main.model.Message
import com.mwaibanda.peacework_multiplatform.main.repository.MessagingRepository

class GetAllConversationMessagesUseCase(
    private val messagingRepository: MessagingRepository
) {
    suspend operator fun invoke(conversationId: String): List<Message> {
        return messagingRepository.getAllConversationMessages(conversationId)
    }
}