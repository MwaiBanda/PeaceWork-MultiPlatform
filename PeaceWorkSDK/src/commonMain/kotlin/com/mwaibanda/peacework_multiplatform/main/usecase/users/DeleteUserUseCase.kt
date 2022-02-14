package com.mwaibanda.peacework_multiplatform.main.usecase.users

import com.mwaibanda.peacework_multiplatform.main.repository.UserRepository

class DeleteUserUseCase(
    private val userRepository: UserRepository
) {
    suspend operator fun invoke(userId: String){
        userRepository.deleteUser(userId)
    }
}