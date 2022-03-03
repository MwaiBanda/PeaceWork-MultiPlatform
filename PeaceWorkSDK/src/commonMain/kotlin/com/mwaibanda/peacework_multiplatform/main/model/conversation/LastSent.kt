package com.mwaibanda.peacework_multiplatform.main.model.conversation

import kotlinx.serialization.Serializable

@Serializable
data class LastSent(
    val userId: String,
    val message: String,
    val lastSentDate: String,
    val isSeen: Boolean
)
