//
//  PeaceWorkUserDTO.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/27/21.
//

import Foundation

struct PeaceWorkUserDTO: Encodable {
    let id: String = String(UUID().uuidString.prefix(14))
    let createdOn: String
    let fullname: String
    let email: String
    let userID: String
}
 
