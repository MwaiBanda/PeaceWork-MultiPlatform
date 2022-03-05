package com.mwaibanda.peacework_multiplatform.main.model.conversation

import kotlinx.serialization.Serializable

@Serializable
data class Participant(
    val userId: String,
    val username: String
)
