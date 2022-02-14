package com.mwaibanda.peacework_multiplatform.data.remote

import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation
import com.mwaibanda.peacework_multiplatform.main.repository.ConversationRepository
import com.mwaibanda.peacework_multiplatform.data.PeaceWorkRepositoryBase
import io.github.reactivecircus.cache4k.Cache
import io.ktor.client.*
import io.ktor.client.request.*

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
}