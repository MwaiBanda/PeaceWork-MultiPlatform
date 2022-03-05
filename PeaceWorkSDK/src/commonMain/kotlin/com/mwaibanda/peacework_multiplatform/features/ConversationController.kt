package com.mwaibanda.peacework_multiplatform.features

import com.mwaibanda.peacework_multiplatform.data.PeaceWorkRepositoryBase
import com.mwaibanda.peacework_multiplatform.main.model.Message
import com.mwaibanda.peacework_multiplatform.main.model.conversation.Conversation
import com.mwaibanda.peacework_multiplatform.main.model.conversation.LastSent
import com.mwaibanda.peacework_multiplatform.main.usecase.conversations.GetUserConversationsByIdUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.conversations.UpdateLastSentUseCase
import io.github.reactivecircus.cache4k.Cache
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

open class ConversationController: KoinComponent {
    private val scope = MainScope()
    private val getUserConversationsByIdUseCase: GetUserConversationsByIdUseCase by inject()
    private  val updateLastSentUseCase: UpdateLastSentUseCase by inject()
    private  val cache: Cache<String, List<Conversation>> by inject()

    suspend fun getUserConversationsById(id: String): List<Conversation> {
        return getUserConversationsByIdUseCase(id)
    }

    fun updateLastSent(conversationId: String, lastSent: LastSent) {
        scope.launch {
            updateLastSentUseCase(conversationId, lastSent)
        }
    }

    fun clearConversations() {
        cache.invalidate(PeaceWorkRepositoryBase.CONVERSATIONS_KEY)
    }
}