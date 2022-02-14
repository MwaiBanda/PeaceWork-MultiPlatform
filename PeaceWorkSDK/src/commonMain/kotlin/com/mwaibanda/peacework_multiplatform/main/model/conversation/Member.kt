package com.mwaibanda.peacework_multiplatform.main.model.conversation

import kotlinx.serialization.Serializable

@Serializable
data class Member(
    val id: String,
    val username: String
)
