package com.mwaibanda.peacework_multiplatform.data.remote

import com.mwaibanda.peacework_multiplatform.data.PeaceWorkRepositoryBase
import com.mwaibanda.peacework_multiplatform.data.dto.MessageDTO
import com.mwaibanda.peacework_multiplatform.main.model.Message
import com.mwaibanda.peacework_multiplatform.main.repository.MessagingRepository
import com.mwaibanda.peacework_multiplatform.utils.Resource
import io.github.reactivecircus.cache4k.Cache
import io.ktor.client.*
import io.ktor.client.features.websocket.*
import io.ktor.client.request.*
import io.ktor.http.cio.websocket.*
import kotlinx.coroutines.channels.consumeEach
import kotlinx.coroutines.flow.*
import kotlinx.coroutines.isActive
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

class MessagingRepositoryImpl(
    private val httpClient: HttpClient,
    private val cache: Cache<String, List<Message>>
): MessagingRepository, PeaceWorkRepositoryBase() {
    private  var socket: WebSocketSession? = null
    override suspend fun getAllConversationMessages(conversationId: String): List<Message> {
        val cachedMessages: List<Message> = cache.get(conversationId).orEmpty()
        if (cachedMessages.isNotEmpty()) return cachedMessages
        val remoteMessages: List<Message> = httpClient.get<List<MessageDTO>> {
            peaceWorkAPI("/messages/$conversationId")
        }.map { it.toMessage() }
        cache.put(conversationId, remoteMessages)
        return remoteMessages
    }
    override suspend fun joinConversation(conversationId: String, userId: String): Resource<Unit> {
        return try {
            socket = httpClient.webSocketSession {
                peaceWorkAPI("$MESSAGING_ENDPOINT/$conversationId?userId=$userId", urlType = Companion.URLType.WebSockets)
            }
            if (socket?.isActive == true){
                Resource.Success(Unit)
            } else Resource.Error("connection failed")
        } catch (e: Throwable) {
            e.printStackTrace()
            Resource.Error(e.message ?: "Unknown")
        }
    }

    override suspend fun observeMessages(message: (Message) -> Unit) {
         try {
            socket?.incoming?.consumeEach {
                when (it) {
                    is Frame.Text -> {
                        val json = (it as? Frame.Text)?.readText() ?: ""
                        val messageDTO: MessageDTO = Json.decodeFromString(json)
                        message(messageDTO.toMessage())
                    }
                    else -> {}
                }
            }
        } catch (e: Throwable) {
            e.printStackTrace()

        }
    }

    override suspend fun leaveConversation(username: String) {
        socket?.close()
    }

    override suspend fun sendMessage(message: String) {
       try {
           socket?.send(Frame.Text(message))
       } catch (e: Throwable) {
           e.printStackTrace()
       }
    }
}