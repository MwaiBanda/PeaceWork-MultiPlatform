//
//  JobType.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/8/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation

enum  JobType {
    case FullTime
    case PartTime
    case Either
    
    var identifier: String {
        switch self {
        case .FullTime:
            return "Full-time"
        case .PartTime:
            return "Part-time"
        case .Either:
            return "Either full-time or part-time"
        }
    }
}
