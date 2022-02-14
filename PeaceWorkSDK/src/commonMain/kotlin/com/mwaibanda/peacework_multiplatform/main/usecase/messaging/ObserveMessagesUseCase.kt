package com.mwaibanda.peacework_multiplatform.main.usecase.messaging

import com.mwaibanda.peacework_multiplatform.main.model.Message
import com.mwaibanda.peacework_multiplatform.main.repository.MessagingRepository
import kotlinx.coroutines.flow.Flow

class ObserveMessagesUseCase (
    private val messagingRepository: MessagingRepository
    ) {
        suspend operator fun invoke(message: (Message) -> Unit) {
             messagingRepository.observeMessages {
                message(it)
            }
        }
    }