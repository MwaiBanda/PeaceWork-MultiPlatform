package com.mwaibanda.peacework_multiplatform.data.dto

import com.mwaibanda.peacework_multiplatform.main.model.Message
import kotlinx.serialization.Serializable

@Serializable
data class MessageDTO(
    val id: String,
    val text: String,
    val userId: String,
    val timestamp: Long,
    val date: String,
    val conversationId: String
) {
    fun toMessage(): Message {
        return Message(
            id = id,
            text = text,
            userId = userId,
             formattedTime = date,
         conversationId = conversationId
        )
    }


}
