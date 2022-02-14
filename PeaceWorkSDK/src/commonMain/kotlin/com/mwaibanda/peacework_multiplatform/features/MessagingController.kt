package com.mwaibanda.peacework_multiplatform.features

import com.mwaibanda.peacework_multiplatform.data.dto.MessageDTO
import com.mwaibanda.peacework_multiplatform.main.model.Message
import com.mwaibanda.peacework_multiplatform.main.usecase.messaging.*
import com.mwaibanda.peacework_multiplatform.utils.Cancellable
import io.github.reactivecircus.cache4k.Cache
import kotlinx.coroutines.flow.Flow
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

open class MessagingController : KoinComponent {
    private val sendMessageUseCase: SendMessageUseCase by inject()
    private val observeMessagesUseCase: ObserveMessagesUseCase by inject()
    private val joinConversationUseCase: JoinConversationUseCase by inject()
    private val leaveConversationUseCase: LeaveConversationUseCase by inject()
    private  val getAllConversationMessagesUseCase: GetAllConversationMessagesUseCase by inject()
    private  val cache: Cache<String, List<Message>> by inject()

    suspend fun observeMessages(message: (Message) -> Unit) {
        observeMessagesUseCase {
            message(it)
        }
    }

    fun getMessageFromString(message: String): Message {
        val messageDTO: MessageDTO = Json.decodeFromString(message)
        return messageDTO.toMessage()
    }

    suspend fun joinConversation(conversationId: String, username: String) {
        joinConversationUseCase(conversationId, username)
    }

    suspend fun sendMessage(message: String) {
        sendMessageUseCase(message)
    }

    suspend fun leaveConversation(username: String) {
       leaveConversationUseCase(username)
    }
    suspend fun getAllConversationMessages(conversationId: String): List<Message> {
        return getAllConversationMessagesUseCase(conversationId)
    }

    fun updateConversationMessages(conversationId: String, messages: List<Message>){
        cache.put(conversationId, messages)
    }

}