package com.mwaibanda.peacework_multiplatform.data.dto

import com.mwaibanda.peacework_multiplatform.main.model.Message
import kotlinx.serialization.Serializable

@Serializable
data class MessageDTO(
    val id: String,
    val text: String,
    val username: String,
    val timestamp: Long,
    val conversationId: String
) {
    fun toMessage(): Message {
        return Message(
            id = id,
            text = text,
             username = username,
             formattedTime = timestamp,
         conversationId = conversationId
        )
    }


}
