package com.mwaibanda.peacework_multiplatform.main.model.reel

import kotlinx.serialization.Serializable

@Serializable
data class Reel(
    val id: String,
    val title: String,
    val coverDescription: String,
    val payRange: String,
    val budget: String,
    val images: List<ReelImage>,
    val detailDescriptions: List<DetailDescription>,
    val targetAudience: String,
    val startDate: String,
    val endDate: String
)

