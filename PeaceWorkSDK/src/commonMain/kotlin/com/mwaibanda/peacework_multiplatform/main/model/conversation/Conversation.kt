package com.mwaibanda.peacework_multiplatform.main.model.conversation

import kotlinx.serialization.Serializable


@Serializable
data class Conversation(
    val id: String,
    val participants: List<Member>,
    val lastSent: LastSent,
    val timestamp: Long
)
