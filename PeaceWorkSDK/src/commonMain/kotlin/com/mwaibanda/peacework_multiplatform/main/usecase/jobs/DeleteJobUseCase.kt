package com.mwaibanda.peacework_multiplatform.main.usecase.jobs

import com.mwaibanda.peacework_multiplatform.main.repository.JobsRepository


class DeleteJobUseCase (
    private val jobsRepository: JobsRepository
) {
    suspend operator fun invoke(id: String) {
        jobsRepository.deleteJob(id)
    }
}