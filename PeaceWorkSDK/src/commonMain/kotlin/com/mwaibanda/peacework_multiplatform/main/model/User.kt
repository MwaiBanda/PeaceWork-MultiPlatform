package com.mwaibanda.peacework_multiplatform.main.model

import kotlinx.serialization.Serializable

@Serializable
data class User (
    val id: String,
    var createdOn: String,
    var fullname: String,
    var email: String,
    var userID: String,
    var company: String,
    var position: String,
    var dateStarted: String
)
