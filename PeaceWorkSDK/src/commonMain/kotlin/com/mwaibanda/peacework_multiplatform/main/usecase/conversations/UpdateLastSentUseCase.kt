package com.mwaibanda.peacework_multiplatform.main.usecase.conversations

import com.mwaibanda.peacework_multiplatform.main.model.conversation.LastSent
import com.mwaibanda.peacework_multiplatform.main.repository.ConversationRepository

class UpdateLastSentUseCase(
    private val conversationRepository: ConversationRepository
) {
    suspend operator fun invoke(conversationId: String, lastSent: LastSent) {
        conversationRepository.updateLastSent(conversationId, lastSent)
    }
}