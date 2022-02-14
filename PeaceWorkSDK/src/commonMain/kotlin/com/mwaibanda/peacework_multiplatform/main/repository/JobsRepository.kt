package com.mwaibanda.peacework_multiplatform.main.repository

import com.mwaibanda.peacework_multiplatform.main.model.Job

interface JobsRepository {
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
    )
    suspend fun getAllJobs(): List<Job>
    suspend fun getUserJobsById(id: String): List<Job>
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
    )
    suspend fun deleteJob(id: String)
}