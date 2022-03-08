package com.mwaibanda.peacework_multiplatform.data.remote

import com.mwaibanda.peacework_multiplatform.data.PeaceWorkRepositoryBase
import com.mwaibanda.peacework_multiplatform.main.model.Job
import com.mwaibanda.peacework_multiplatform.main.repository.JobsRepository
import io.github.reactivecircus.cache4k.Cache
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.request.forms.*
import io.ktor.client.statement.*
import io.ktor.http.*

class JobsRepositoryImpl(
    private val httpClient: HttpClient,
    private val cache: Cache<String, List<Job>>
): JobsRepository, PeaceWorkRepositoryBase() {
    override suspend fun getUserJobsById(id: String): List<Job> {
        val cachedJobs: List<Job> = cache.get(id).orEmpty()
        if (cachedJobs.isNotEmpty()) return cachedJobs
        val remoteJobs: List<Job> = httpClient.get {
            peaceWorkAPI("/jobs/user/$id")
            parameter("userId", id)

        }
        cache.put(id, remoteJobs)
        return remoteJobs
    }

    override suspend fun getAllJobs(): List<Job> {
        val cachedJobs: List<Job> = cache.get(JOBS_KEY).orEmpty()
        if (cachedJobs.isNotEmpty()) return cachedJobs
        val remoteJobs: List<Job> =  httpClient.get {
            peaceWorkAPI("/jobs")
        }
        cache.put(JOBS_KEY, remoteJobs)
        return remoteJobs
    }

    override suspend fun updateJob(
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
        httpClient.submitForm<HttpResponse>(
            url = "${JOBS_ENDPOINT}/$id",
            formParameters = Parameters.build {
                append("id", id)
                append("title", title)
                append("company", company)
                append("location", location)
                append("pay", pay)
                append("payRate", payRate)
                append("type", type)
                append("employmentType", employmentType)
                append("description", description)
                append("qualifications", qualifications)
                append("responsibilities", responsibilities)
                append("startDate", startDate)
                append("publisher", publisher)
                append("contactEmail", contactEmail)

            }
        ) { method = HttpMethod.Put }
    }

    override suspend fun deleteJob(id: String) {
        httpClient.request<HttpResponse>{
            peaceWorkAPI("/jobs/$id")
            method = HttpMethod.Delete

        }
    }
    override suspend fun postJob(
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
        httpClient.submitForm<HttpResponse>(
            url = JOBS_ENDPOINT,
            formParameters = Parameters.build {
                append("title", title)
                append("company", company)
                append("location", location)
                append("pay", pay)
                append("payRate", payRate)
                append("type", type)
                append("employmentType", employmentType)
                append("description", description)
                append("qualifications", qualifications)
                append("responsibilities", responsibilities)
                append("startDate", startDate)
                append("publisher", publisher)
                append("contactEmail", contactEmail)

            }
        )
    }
}