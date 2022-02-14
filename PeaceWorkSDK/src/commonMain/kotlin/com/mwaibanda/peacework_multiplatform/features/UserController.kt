package com.mwaibanda.peacework_multiplatform.features

import com.mwaibanda.peacework_multiplatform.main.model.User
import com.mwaibanda.peacework_multiplatform.main.usecase.users.DeleteUserUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.users.GetUserProfileUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.users.PostUserUseCase
import com.mwaibanda.peacework_multiplatform.main.usecase.users.UpdateUserProfileUseCase
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

open class UserController: KoinComponent {
    private val postUserUseCase: PostUserUseCase by inject()
    private val getUserProfileUseCase: GetUserProfileUseCase by inject()
    private val updateUserProfileUseCase: UpdateUserProfileUseCase by inject()
    private val deleteUserUseCase: DeleteUserUseCase by inject()

    suspend fun getUserProfile(userID: String): User {
        return getUserProfileUseCase(userID)
    }
    suspend fun postNewUser(
        createdOn: String,
        fullname: String,
        email: String,
        userID: String,
        company: String,
        position: String,
        dateStarted: String
    ){
        postUserUseCase(createdOn, fullname, email, userID, company, position, dateStarted)
    }
    suspend fun updateUser(
        createdOn: String,
        fullname: String,
        email: String,
        userID: String,
        company: String,
        position: String,
        dateStarted: String
    ){
        updateUserProfileUseCase(createdOn, fullname, email, userID, company, position, dateStarted)
    }
    suspend fun deleteUser(userID: String) {
        deleteUserUseCase(userID)
    }
}
