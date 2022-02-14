package com.mwaibanda.peacework_multiplatform.main.usecase.messaging

import com.mwaibanda.peacework_multiplatform.main.repository.MessagingRepository

class JoinConversationUseCase(
    private val messagingRepository: MessagingRepository
) {
    suspend operator fun invoke(conversationId: String, username: String) {
        messagingRepository.joinConversation(conversationId, username)
    }
}