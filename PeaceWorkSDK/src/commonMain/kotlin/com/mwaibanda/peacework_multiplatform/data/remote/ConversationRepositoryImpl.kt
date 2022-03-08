package com.mwaibanda.peacework_multiplatform.data.remote

import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation
import com.mwaibanda.peacework_multiplatform.main.repository.ConversationRepository
import com.mwaibanda.peacework_multiplatform.data.PeaceWorkRepositoryBase
import com.mwaibanda.peacework_multiplatform.main.model.conversation.LastSent
import com.mwaibanda.peacework_multiplatform.main.model.conversation.Participant
import io.github.reactivecircus.cache4k.Cache
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.request.forms.*
import io.ktor.client.statement.*
import io.ktor.http.*
import kotlinx.datetime.Clock

class ConversationRepositoryImpl(
    private val httpClient: HttpClient,
    private val cache: Cache<String, List<Conversation>>
): ConversationRepository, PeaceWorkRepositoryBase() {

    override suspend fun getUserConversationsById(id: String): List<Conversation> {
        val cachedConversations: List<Conversation> = cache.get(CONVERSATIONS_KEY).orEmpty()
        if (cachedConversations.isNotEmpty()) return cachedConversations
        val remoteConversations: List<Conversation> =  httpClient.get {
            peaceWorkAPI(CONVERSATIONS_ENDPOINT)
            parameter("userId", id)

        }
        cache.put(CONVERSATIONS_KEY, remoteConversations)
        return remoteConversations
    }

    override suspend fun createConversation(participants: List<Participant>, onCompletion: (Conversation) -> Unit) {
        val conversation = Conversation(
            participants = participants,
            lastSent = LastSent(
                userId = "",
                message = "Tap To Message\uD83D\uDCE8",
                lastSentDate = "",
                isSeen = false
            ), timestamp = Clock.System.now().toEpochMilliseconds()
        )
        val response: HttpResponse = httpClient.post {
            peaceWorkAPI(CONVERSATIONS_ENDPOINT)
            parameter("userId", participants.first().userId)
            contentType(ContentType.Application.Json)
            body = conversation
        }
        onCompletion(conversation)
    }

    override suspend fun updateLastSent(conversationId: String, lastSent: LastSent) {
        httpClient.submitForm<HttpResponse>(
            url = "$BASE_CONVERSATIONS_ENDPOINT/last-sent/$conversationId",
            formParameters = Parameters.build {
                append("conversationId", conversationId)
                append("isSeen", "${lastSent.isSeen}")
                append("message", lastSent.message)
                append("lastSentDate", lastSent.lastSentDate)
                append("userId", lastSent.userId)

            }
        ) {
            method = HttpMethod.Put
            parameter("userId", lastSent.userId)
        }
    }

    override suspend fun deleteConversation(conversationId: String) {
        val response: HttpResponse = httpClient.delete {
            peaceWorkAPI("$CONVERSATIONS_ENDPOINT/$conversationId")
        }
    }
}