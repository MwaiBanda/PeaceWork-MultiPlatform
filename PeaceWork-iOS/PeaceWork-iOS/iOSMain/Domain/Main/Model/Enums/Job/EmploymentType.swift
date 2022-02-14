//
//  EmploymentType.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/8/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import Foundation

enum  EmploymentType {
    case Contract
    case Temporary
    case Internship
    
    var identifier: String {
        switch self {
        case .Contract:
            return "Contract"
        case .Temporary:
            return "Temporary"
        case .Internship:
            return "Internships"
        }
    }
}
