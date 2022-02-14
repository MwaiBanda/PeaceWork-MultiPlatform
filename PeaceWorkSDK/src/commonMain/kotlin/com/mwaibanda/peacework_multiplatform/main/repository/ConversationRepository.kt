package com.mwaibanda.peacework_multiplatform.main.repository

import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation

interface ConversationRepository {
    suspend fun getUserConversationsById(id: String): List<Conversation>
}