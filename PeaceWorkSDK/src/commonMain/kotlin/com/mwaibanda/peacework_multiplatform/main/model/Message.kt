package com.mwaibanda.peacework_multiplatform.main.model

import kotlinx.serialization.Serializable

@Serializable
data class Message(
    val id: String,
    val text: String,
    val userId: String,
    val formattedTime: String,
    val conversationId: String
)
