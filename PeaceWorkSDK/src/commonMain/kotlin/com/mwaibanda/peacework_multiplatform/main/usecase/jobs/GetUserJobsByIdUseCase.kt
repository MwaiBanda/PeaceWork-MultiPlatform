package com.mwaibanda.peacework_multiplatform.main.usecase.jobs

import com.mwaibanda.peacework_multiplatform.main.repository.JobsRepository
import com.mwaibanda.peacework_multiplatform.main.model.Job

class GetUserJobsByIdUseCase(
    private val jobsRepository: JobsRepository
) {
    suspend operator fun invoke(id: String): List<Job> {
        return jobsRepository.getUserJobsById(id)
    }
}