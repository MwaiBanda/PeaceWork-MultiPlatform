package com.mwaibanda.peacework_multiplatform.data.remote

import com.mwaibanda.peacework_multiplatform.data.PeaceWorkRepositoryBase
import com.mwaibanda.peacework_multiplatform.main.model.Job
import com.mwaibanda.peacework_multiplatform.main.model.user.User
import com.mwaibanda.peacework_multiplatform.main.repository.UserRepository
import com.russhwolf.settings.ExperimentalSettingsApi
import com.russhwolf.settings.Settings
import com.russhwolf.settings.serialization.encodeValue
import com.russhwolf.settings.serialization.nullableSerializedValue
import io.github.reactivecircus.cache4k.Cache
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.request.forms.*
import io.ktor.client.statement.*
import io.ktor.http.*
import kotlinx.serialization.ExperimentalSerializationApi

@ExperimentalSettingsApi
@ExperimentalSerializationApi
class UserRepositoryImpl(
    private val httpClient: HttpClient,
    private val cache: Settings
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
        httpClient.post<HttpResponse> {
            peaceWorkAPI("/users")
            contentType(ContentType.Application.Json)
            body = User(
                createdOn = createdOn,
                fullname = fullname,
                email = email,
                userID = userID,
                company = company,
                position = position,
                dateStarted = dateStarted,
                contacts = emptyList()
            )
        }
    }
    override suspend fun getUserProfile(userID: String): User {
        val cachedJobs: User?  by cache.nullableSerializedValue(User.serializer(), PROFILE_KEY)

        if (cachedJobs != null) return cachedJobs as User
        val profile: User = httpClient.get {
            peaceWorkAPI("/users/$userID")
            parameter("userId", userID)
        }
        cache.encodeValue(User.serializer(), PROFILE_KEY, profile)

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