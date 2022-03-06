package com.mwaibanda.peacework_multiplatform.main.usecase.users

import com.mwaibanda.peacework_multiplatform.main.model.user.User
import com.mwaibanda.peacework_multiplatform.main.repository.UserRepository

class GetUserProfileUseCase(
    private val userRepository: UserRepository
) {
    suspend operator fun invoke(userId: String): User {
        return userRepository.getUserProfile(userId)
    }
}