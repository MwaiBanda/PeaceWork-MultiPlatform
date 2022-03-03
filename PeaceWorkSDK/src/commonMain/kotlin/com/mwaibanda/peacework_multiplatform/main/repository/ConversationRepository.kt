package com.mwaibanda.peacework_multiplatform.main.repository

import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation
import com.mwaibanda.peacework_multiplatform.main.model.conversation.LastSent

interface ConversationRepository {
    suspend fun getUserConversationsById(id: String): List<Conversation>
    suspend fun insertConversation(conversation: Conversation)
    suspend fun updateLastSent(conversationId: String, lastSent: LastSent)
    suspend fun deleteConversation(conversationId: String)
}