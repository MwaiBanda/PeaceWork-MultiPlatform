package com.mwaibanda.peacework_multiplatform.main.model

import kotlinx.serialization.Serializable

@Serializable
data class Job(
    val id: String,
    val title: String,
    val company: String,
    val location: String,
    val pay: String,
    val payRate: String,
    val type: String,
    val employmentType: String,
    val description: String,
    val qualifications: String,
    val responsibilities: String,
    val startDate: String,
    val publisher: String,
    val contactEmail: String,
)










