package com.mwaibanda.peacework_multiplatform.main.model

import kotlinx.serialization.Serializable

@Serializable
data class Message(
    val id: String,
    val text: String,
    val username: String,
    val formattedTime: Long,
    val conversationId: String
)
