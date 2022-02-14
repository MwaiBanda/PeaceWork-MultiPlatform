package com.mwaibanda.peacework_multiplatform.main.model.reel

import kotlinx.serialization.Serializable

@Serializable
data class ReelImage(
    val tag: Int,
    val href: String
)
