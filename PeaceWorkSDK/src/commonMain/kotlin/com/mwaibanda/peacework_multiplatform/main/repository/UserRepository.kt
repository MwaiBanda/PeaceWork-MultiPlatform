package com.mwaibanda.peacework_multiplatform.main.repository

import com.mwaibanda.peacework_multiplatform.main.model.User

interface UserRepository {
    suspend fun getUserProfile(userID: String): User
    suspend fun updateUser(
        createdOn: String,
        fullname: String,
        email: String,
        userID: String,
        company: String,
        position: String,
        dateStarted: String
    )
    suspend fun postUser(
        createdOn: String,
        fullname: String,
        email: String,
        userID: String,
        company: String,
        position: String,
        dateStarted: String
    )
    suspend fun deleteUser(userID: String)
}