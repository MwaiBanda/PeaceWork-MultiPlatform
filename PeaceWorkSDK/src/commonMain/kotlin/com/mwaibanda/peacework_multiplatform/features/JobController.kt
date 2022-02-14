package com.mwaibanda.peacework_multiplatform.features

import com.mwaibanda.peacework_multiplatform.main.model.Job
import com.mwaibanda.peacework_multiplatform.main.usecase.jobs.*
import io.github.reactivecircus.cache4k.Cache
import org.koin.core.component.KoinComponent
import org.koin.core.component.inject

open class JobController: KoinComponent {
    private val getJobsUseCase: GetJobsUseCase by inject()
    private val postJobUseCase: PostJobUseCase by inject()
    private val getUserJobsByIdUseCase: GetUserJobsByIdUseCase by inject()
    private val updateJobUseCase: UpdateJobUseCase by inject()
    private val deleteJobUseCase: DeleteJobUseCase by inject()
    private val cache: Cache<String, List<Job>> by inject()
    


    suspend fun getJobs(): List<Job> {
        return getJobsUseCase()
    }
    suspend fun deleteJob(id: String) {
        deleteJobUseCase(id)
    }

    suspend fun getJobsById(id: String): List<Job> {
        return getUserJobsByIdUseCase(id)
    }
    suspend fun updateJob(
        id: String,
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
    ) {
        updateJobUseCase(id, title, company, location, pay, payRate, type, employmentType, description, qualifications, responsibilities, startDate, publisher, contactEmail)
    }
    suspend fun postJob(
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
        postJobUseCase(
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

    fun clearUserJobs(id: String){
        cache.invalidate(id)
  }
}

