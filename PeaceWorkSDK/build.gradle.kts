plugins {
    kotlin("multiplatform")
    kotlin("native.cocoapods")
    id("com.android.library")
    kotlin("plugin.serialization")


}

version = "1.0.0"

kotlin {
    android()
    iosX64()
    iosArm64()
    //iosSimulatorArm64() sure all ios dependencies support this target

    cocoapods {
        summary = "Some description for the Shared Module"
        homepage = "Link to the Shared Module homepage"
        ios.deploymentTarget = "14.1"
        podfile = project.file("../PeaceWork-iOS/Podfile")
        framework {
            baseName = "PeaceWorkSDK"
        }
    }
    
    sourceSets {
        val commonMain by getting {
            dependencies {
                implementation ("co.touchlab:stately-common:1.2.1")
                implementation ("co.touchlab:stately-isolate:1.2.1")
                implementation ("co.touchlab:stately-iso-collections:1.2.1")
                implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.0-native-mt"){
                    version {
                        strictly("1.6.0-native-mt")
                    }
                }
                implementation("io.ktor:ktor-client-core:1.6.7")



                implementation("io.ktor:ktor-client-websockets:1.6.7")
                implementation("io.ktor:ktor-client-serialization:1.6.3")
                implementation("io.ktor:ktor-client-logging:1.6.2")
                implementation("org.jetbrains.kotlinx:kotlinx-serialization-core:1.3.1")
                implementation("io.insert-koin:koin-core:3.1.4")
                implementation("io.github.reactivecircus.cache4k:cache4k:0.4.0")

            }
        }
        val commonTest by getting {
            dependencies {
                implementation(kotlin("test-common"))
                implementation(kotlin("test-annotations-common"))
            }
        }
        val androidMain by getting{
            dependencies {
                implementation("com.squareup.okhttp3:okhttp:5.0.0-alpha.3")
            }
        }
        val androidTest by getting {
            dependencies {
                implementation(kotlin("test-junit"))
                implementation("junit:junit:4.13.2")
            }
        }
        val iosX64Main by getting
        val iosArm64Main by getting
        // val iosSimulatorArm64Main by getting

        val iosMain by creating {
            dependsOn(commonMain)
            iosX64Main.dependsOn(this)
            iosArm64Main.dependsOn(this)
            //iosSimulatorArm64Main.dependsOn(this)
            dependencies {
                implementation("io.ktor:ktor-client-ios:1.6.3")
                implementation ("org.jetbrains.kotlinx:kotlinx-coroutines-core:1.6.0-native-mt"){
                    version {
                        strictly("1.6.0-native-mt")
                    }
                }
            }
        }

        val iosX64Test by getting
        val iosArm64Test by getting
        //val iosSimulatorArm64Test by getting
        val iosTest by creating {
            dependsOn(commonTest)
            iosX64Test.dependsOn(this)
            iosArm64Test.dependsOn(this)
            //iosSimulatorArm64Test.dependsOn(this)
        }
    }
}

android {
    compileSdk = 31
    sourceSets["main"].manifest.srcFile("src/androidMain/AndroidManifest.xml")
    defaultConfig {
        minSdk = 21
        targetSdk = 31
    }
}