package com.mwaibanda.peacework_multiplatform.data

import co.touchlab.stately.ensureNeverFrozen
import io.ktor.client.request.*
import io.ktor.http.*

open class PeaceWorkRepositoryBase {
    init {
        ensureNeverFrozen()
    }

    companion object {
        enum class URLType {
            Http, WebSockets
        }
        /* BASE URL */
        private const val BASE_URL = "http://10.0.0.55:8080"
        private const val BASE_WEBSOCKETS_URL = "ws://10.0.0.55:8080"
        /* KEYS */
        const val JOBS_KEY = "JOBS"
        const val CONVERSATIONS_KEY = "CONVERSATIONS"
        /* ENDPOINTS */
        const val USERS_ENDPOINT = "$BASE_URL/users"
        const val JOBS_ENDPOINT = "$BASE_URL/jobs"
        const val CONVERSATIONS_ENDPOINT = "/conversations"
        const val BASE_CONVERSATIONS_ENDPOINT = "$BASE_URL/conversations"
        const val MESSAGING_ENDPOINT = "/message"

        fun HttpRequestBuilder.peaceWorkAPI(path: String, urlType: URLType = URLType.Http) {
            url {
                when (urlType){
                    URLType.Http -> takeFrom(BASE_URL)
                    URLType.WebSockets -> takeFrom(BASE_WEBSOCKETS_URL)
                }
                encodedPath = path
            }
        }
    }
}