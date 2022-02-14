package com.mwaibanda.peacework_multiplatform.main.usecase.jobs

import com.mwaibanda.peacework_multiplatform.main.repository.JobsRepository

class PostJobUseCase(
    private val jobsRepository: JobsRepository
) {
    suspend operator fun invoke(
        title: String,
        company: String,
        location: String,
        pay: String,
        payRate: String,
        type: String,
        employmentType: String,
        description: String,
        qualifications: String,
        responsibilities: String,
        startDate: String,
        publisher: String,
        contactEmail: String
    ){
        jobsRepository.postJob(
            title,
            company,
            location,
            pay,
            payRate,
            type,
            employmentType,
            description,
            qualifications,
            responsibilities,
            startDate,
            publisher,
            contactEmail
        )
    }
}