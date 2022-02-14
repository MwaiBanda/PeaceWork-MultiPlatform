package com.mwaibanda.peacework_multiplatform.main.usecase.messaging

import com.mwaibanda.peacework_multiplatform.main.repository.MessagingRepository

class LeaveConversationUseCase (
    private val messagingRepository: MessagingRepository
) {
    suspend operator fun invoke(username: String) {
        messagingRepository.leaveConversation(username)
    }
}