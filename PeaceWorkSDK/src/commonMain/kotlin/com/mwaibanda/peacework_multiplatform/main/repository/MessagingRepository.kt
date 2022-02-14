package com.mwaibanda.peacework_multiplatform.main.repository

import com.mwaibanda.peacework_multiplatform.main.model.Message
import com.mwaibanda.peacework_multiplatform.utils.Resource
import kotlinx.coroutines.flow.Flow

interface MessagingRepository {
    suspend fun sendMessage(message: String)
    suspend fun observeMessages(message: (Message) -> Unit)
    suspend fun leaveConversation(username: String)
    suspend fun getAllConversationMessages(conversationId: String): List<Message>
    suspend fun joinConversation(conversationId: String, username: String): Resource<Unit>
}