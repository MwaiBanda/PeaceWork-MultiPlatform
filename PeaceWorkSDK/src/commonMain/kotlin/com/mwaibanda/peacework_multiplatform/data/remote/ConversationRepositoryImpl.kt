package com.mwaibanda.peacework_multiplatform.data.remote

import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation
import com.mwaibanda.peacework_multiplatform.main.repository.ConversationRepository
import com.mwaibanda.peacework_multiplatform.data.PeaceWorkRepositoryBase
import com.mwaibanda.peacework_multiplatform.main.model.conversation.LastSent
import io.github.reactivecircus.cache4k.Cache
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.http.*

class ConversationRepositoryImpl(
    private val httpClient: HttpClient,
    private val cache: Cache<String, List<Conversation>>
): ConversationRepository, PeaceWorkRepositoryBase() {

    override suspend fun getUserConversationsById(id: String): List<Conversation> {
        val cachedConversations: List<Conversation> = cache.get(CONVERSATIONS_KEY).orEmpty()
        if (cachedConversations.isNotEmpty()) return cachedConversations
        val remoteConversations: List<Conversation> =  httpClient.get {
            peaceWorkAPI("$CONVERSATIONS_ENDPOINT/$id?userId=$id")
        }
        cache.put(CONVERSATIONS_KEY, remoteConversations)
        return remoteConversations
    }

    override suspend fun insertConversation(conversation: Conversation) {
        val response: HttpResponse = httpClient.post {
            peaceWorkAPI(CONVERSATIONS_ENDPOINT)
            contentType(ContentType.Application.Json)
            body = conversation
        }
    }

    override suspend fun updateLastSent(conversationId: String, lastSent: LastSent) {
        val response: HttpResponse = httpClient.put {
            peaceWorkAPI(CONVERSATIONS_ENDPOINT)
            parameter("conversationId", conversationId)
            parameter("isSeen", lastSent.isSeen)
            parameter("message", lastSent.message)
            parameter("lastSentDate", lastSent.lastSentDate)
            parameter("userId", lastSent.userId)
        }
    }

    override suspend fun deleteConversation(conversationId: String) {
        val response: HttpResponse = httpClient.delete {
            peaceWorkAPI("$CONVERSATIONS_ENDPOINT/$conversationId")
        }
    }
}