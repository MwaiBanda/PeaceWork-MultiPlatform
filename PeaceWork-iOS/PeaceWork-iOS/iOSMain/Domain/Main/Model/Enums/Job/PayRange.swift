//
//  PayRange.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/9/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation

enum PayRange {
    case payPerDay
    case payPerHour
    case payPerMonth
    case payPerRange
    
    var identifier: String {
        switch self {
        case .payPerDay:
            return "Per Day"
        case .payPerHour:
            return "Per Hour"
        case .payPerMonth:
            return "Per Month"
        case .payPerRange:
            return "By Range"

        }
    }
}
