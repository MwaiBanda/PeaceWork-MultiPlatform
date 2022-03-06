package com.mwaibanda.peacework_multiplatform.main.model.conversation

import kotlinx.serialization.Serializable


@Serializable
data class Conversation(
    val id: String = "PW22-C${
        (100000..999999).random()
    }",
    val participants: List<Participant>,
    val lastSent: LastSent,
    val timestamp: Long
)
