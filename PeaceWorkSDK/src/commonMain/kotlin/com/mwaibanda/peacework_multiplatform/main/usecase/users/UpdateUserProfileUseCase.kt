package com.mwaibanda.peacework_multiplatform.main.usecase.users

import com.mwaibanda.peacework_multiplatform.main.repository.UserRepository

class UpdateUserProfileUseCase(
    private val userRepository: UserRepository
) {
    suspend operator fun invoke(
        createdOn: String,
        fullname: String,
        email: String,
        userID: String,
        company: String,
        position: String,
        dateStarted: String
    ) {
        userRepository.updateUser(createdOn, fullname, email, userID, company, position, dateStarted)
    }
}