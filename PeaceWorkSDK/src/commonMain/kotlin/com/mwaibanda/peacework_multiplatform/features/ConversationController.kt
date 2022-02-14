package com.mwaibanda.peacework_multiplatform.features

import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation
import com.mwaibanda.peacework_multiplatform.main.usecase.conversations.GetUserConversationsByIdUseCase
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

open class ConversationController: KoinComponent {
    private val getUserConversationsByIdUseCase: GetUserConversationsByIdUseCase by inject()

    suspend fun getUserConversationsById(id: String): List<Conversation> {
        return getUserConversationsByIdUseCase(id)
    }
}