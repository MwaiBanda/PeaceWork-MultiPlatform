package com.mwaibanda.peacework_multiplatform.main.model.conversation

import kotlinx.serialization.Serializable

@Serializable
data class LastSent(
    val id: String,
    val username: String,
    val message: String,
    val isSeen: Boolean
)