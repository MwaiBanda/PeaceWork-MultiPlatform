//
//  PortfolioViewModel.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/9/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation
import PeaceWorkSDK 

class PortfolioViewModel: JobController, ObservableObject {
    override init() {
        super.init()
    }
    func getLocation(location: String) -> Location {
        if location == Location.SingleLocation.rawValue {
            return Location.SingleLocation
        } else if location == Location.MultipleLocations.rawValue {
            return Location.MultipleLocations
        } else if location == Location.Remote.rawValue {
            return Location.MultipleLocations
        }
        return Location.Remote
    }
    func getPayRange(payRange: String) -> PayRange {
        if payRange == PayRange.payPerHour.identifier {
            return PayRange.payPerHour
        } else if payRange == PayRange.payPerDay.identifier {
            return PayRange.payPerDay
        } else if payRange == PayRange.payPerMonth.identifier {
            return PayRange.payPerMonth
        } else if payRange == PayRange.payPerRange.identifier {
            return PayRange.payPerRange
        }
        return PayRange.payPerRange
    }
    func getEmploymentType(employmentType: String) ->  EmploymentType {
        if employmentType == EmploymentType.Contract.identifier {
            return EmploymentType.Contract
        } else if employmentType == EmploymentType.Temporary.identifier  {
            return EmploymentType.Temporary
        } else if employmentType ==  EmploymentType.Internship.identifier  {
            return EmploymentType.Internship
        }
        return  EmploymentType.Contract
    }
    func  getJobType(jobType: String) -> JobType {
        if jobType == JobType.FullTime.identifier {
            return JobType.FullTime
        } else if jobType == JobType.PartTime.identifier {
            return JobType.PartTime
        } else if jobType ==  JobType.Either.identifier  {
            return JobType.Either
        }
        return  JobType.Either
    }
}
