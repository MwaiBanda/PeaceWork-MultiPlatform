package com.mwaibanda.peacework_multiplatform.data.remote

import com.mwaibanda.peacework_multiplatform.data.PeaceWorkRepositoryBase
import com.mwaibanda.peacework_multiplatform.main.model.Job
import com.mwaibanda.peacework_multiplatform.main.model.User
import com.mwaibanda.peacework_multiplatform.main.repository.UserRepository
import io.github.reactivecircus.cache4k.Cache
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.request.forms.*
import io.ktor.client.statement.*
import io.ktor.http.*

class UserRepositoryImpl(
    private val httpClient: HttpClient,
    private val cache: Cache<String, List<Job>>
): UserRepository, PeaceWorkRepositoryBase() {
    override suspend fun postUser(
        createdOn: String,
        fullname: String,
        email: String,
        userID: String,
        company: String,
        position: String,
        dateStarted: String
    ) {
        httpClient.submitForm<HttpResponse>(
            url = USERS_ENDPOINT,
            formParameters = Parameters.build {
                append("createdOn", createdOn)
                append("fullname", fullname)
                append("email", email)
                append("userID", userID)
                append("position", position)
                append("dateStarted", dateStarted)
            }
        )
    }
    override suspend fun getUserProfile(userID: String): User {
        val profile: User = httpClient.get {
            peaceWorkAPI("/users/$userID")
        }
        return profile
    }

    override suspend fun updateUser(
        createdOn: String,
        fullname: String,
        email: String,
        userID: String,
        company: String,
        position: String,
        dateStarted: String
    ) {
        httpClient.submitForm<HttpResponse>(
            url = "${PeaceWorkRepositoryBase.USERS_ENDPOINT}/$userID",
            formParameters = Parameters.build {
                append("createdOn", createdOn)
                append("fullname", fullname)
                append("email", email)
                append("position", position)
                append("dateStarted", dateStarted)
            }
        ) { method = HttpMethod.Put }
    }

    override suspend fun deleteUser(userID: String) {
        httpClient.request<HttpResponse> {
            peaceWorkAPI("/user/$userID")
            method = HttpMethod.Delete
        }
    }
}