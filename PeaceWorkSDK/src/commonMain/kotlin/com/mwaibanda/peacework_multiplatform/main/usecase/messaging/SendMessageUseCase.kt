package com.mwaibanda.peacework_multiplatform.main.usecase.messaging

import com.mwaibanda.peacework_multiplatform.main.repository.MessagingRepository

class SendMessageUseCase (
    private val messagingRepository: MessagingRepository
) {
    suspend operator fun invoke(message: String) {
        messagingRepository.sendMessage(message)
    }
}