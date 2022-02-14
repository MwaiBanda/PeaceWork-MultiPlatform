package com.mwaibanda.peacework_multiplatform.main.usecase.jobs

import com.mwaibanda.peacework_multiplatform.main.repository.JobsRepository
import com.mwaibanda.peacework_multiplatform.main.model.Job

class GetJobsUseCase(
    private val jobsRepository: JobsRepository
)  {
      suspend operator fun invoke(): List<Job> {
          return jobsRepository.getAllJobs()
      }
}