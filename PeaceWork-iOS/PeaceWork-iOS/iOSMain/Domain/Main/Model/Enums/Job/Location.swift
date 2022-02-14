//
//  Location.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/8/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation

enum Location: String {
    case SingleLocation = "Single Location"
    case MultipleLocations = "Multiple Locations"
    case Remote = "Remote"

    var identifier: String {
        switch self {
        case .SingleLocation:
            return "One Location"
        case .MultipleLocations:
            return "Multiple Locations"
        case .Remote:
            return "Remote"
        }
    }
}
