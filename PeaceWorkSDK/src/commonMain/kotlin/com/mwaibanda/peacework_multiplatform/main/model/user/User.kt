package com.mwaibanda.peacework_multiplatform.main.model.user

import kotlinx.serialization.Serializable

@Serializable
data class User (
    val id: String = "PW22-U${
        (100000..999999).random()
    }-${
        listOf(
            "P","E","A","C","E","W","O","R","K"
        ).random()
    }${
        (0..9).random()
    }${
        listOf(
            "P","E","A","C","E","W","O","R","K" 
        ).random()
    }-${(100..999).random()}",
    var createdOn: String,
    var fullname: String,
    var email: String,
    var userID: String,
    var company: String,
    var position: String,
    var dateStarted: String,
    var contacts: List<Contact>
)
