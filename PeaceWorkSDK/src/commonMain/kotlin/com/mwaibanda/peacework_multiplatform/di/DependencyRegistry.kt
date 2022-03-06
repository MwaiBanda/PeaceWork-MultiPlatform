package com.mwaibanda.peacework_multiplatform.di

import com.mwaibanda.peacework_multiplatform.main.repository.*
import com.mwaibanda.peacework_multiplatform.data.remote.ConversationRepositoryImpl
import com.mwaibanda.peacework_multiplatform.data.remote.JobsRepositoryImpl
import com.mwaibanda.peacework_multiplatform.data.remote.MessagingRepositoryImpl
import com.mwaibanda.peacework_multiplatform.data.remote.UserRepositoryImpl
import com.mwaibanda.peacework_multiplatform.main.model.user.User
import com.mwaibanda.peacework_multiplatform.main.usecase.conversations.CreateConversationUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.conversations.GetUserConversationsByIdUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.conversations.UpdateLastSentUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.jobs.*
import com.mwaibanda.peacework_multiplatform.main.usecase.messaging.*
import com.mwaibanda.peacework_multiplatform.main.usecase.users.DeleteUserUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.users.GetUserProfileUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.users.PostUserUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.users.UpdateUserProfileUseCase
import com.russhwolf.settings.Settings
import io.github.reactivecircus.cache4k.Cache
import io.ktor.client.*
import io.ktor.client.features.*
import io.ktor.client.features.json.*
import io.ktor.client.features.json.serializer.*
import io.ktor.client.features.logging.*
import io.ktor.client.features.observer.*
import io.ktor.client.features.websocket.*
import org.koin.core.context.startKoin
import org.koin.core.module.Module
import org.koin.dsl.KoinAppDeclaration
import org.koin.dsl.module
import kotlin.math.sin
import kotlin.time.Duration.Companion.minutes

fun initKoin(appDeclaration: KoinAppDeclaration = {}) =
    startKoin {
        appDeclaration()
        modules(
            singletonModule,
            repositoryModule,
            useCasesModule,
        )
    }

// IOS
fun initKoin() = initKoin {
    modules(
        singletonModule,
        repositoryModule,
        useCasesModule,
    )
}

val singletonModule = module {
    single {
        HttpClient {
            install(WebSockets)
            install(Logging){
                level = LogLevel.ALL
            }
            install(JsonFeature) {
                val json = kotlinx.serialization.json.Json {
                    prettyPrint = true
                    isLenient = true
                }
                serializer = KotlinxSerializer(json)
            }
            install(HttpTimeout) {
                val timeout = 30000L
                connectTimeoutMillis = timeout
                requestTimeoutMillis = timeout
                socketTimeoutMillis = timeout
            }
            ResponseObserver { response ->
                println("HTTP status: ${response.status.value}")
            }
        }
    }
    single<Cache<String, List<Any>>> {
        Cache.Builder()
            .expireAfterWrite(45.minutes)
            .build()
    }
    single { Settings() }
}
val repositoryModule = module {
    single <JobsRepository> { JobsRepositoryImpl(get(), get()) }
    single <UserRepository> { UserRepositoryImpl(get(), get()) }
    single <ConversationRepository> { ConversationRepositoryImpl(get(), get()) }
    single <MessagingRepository> { MessagingRepositoryImpl(get(), get()) }
}

val useCasesModule: Module = module {
    /* USER USE CASES */
    single { PostUserUseCase(get()) }
    single { GetUserProfileUseCase(get()) }
    single { UpdateUserProfileUseCase(get()) }
    single { DeleteUserUseCase(get()) }
    /* JOB USE CASES */
    single { PostJobUseCase(get()) }
    single { GetJobsUseCase(get()) }
    single { GetUserJobsByIdUseCase(get()) }
    single { UpdateJobUseCase(get()) }
    single { DeleteJobUseCase(get()) }
    /* CONVERSATION USE CASES */
    single { CreateConversationUseCase(get()) }
    single { GetUserConversationsByIdUseCase(get()) }
    single { UpdateLastSentUseCase(get()) }
    /* MESSAGING USE CASES */
    single { GetAllConversationMessagesUseCase(get()) }
    single { JoinConversationUseCase(get()) }
    single { LeaveConversationUseCase(get()) }
    single { ObserveMessagesUseCase(get()) }
    single { SendMessageUseCase(get()) }

}




