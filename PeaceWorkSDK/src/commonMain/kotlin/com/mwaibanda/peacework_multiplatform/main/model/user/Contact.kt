package com.mwaibanda.peacework_multiplatform.main.model.user

import kotlinx.serialization.Serializable

@Serializable
data class Contact(
    val userID: String,
    val username: String
)

