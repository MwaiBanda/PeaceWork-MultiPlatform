//
//  Encodable+Swift.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/27/21.
//

import Foundation

extension Encodable {
    
    func toJSONString() -> String {
        let jsonData = try! JSONEncoder().encode(self)
        return String(data: jsonData, encoding: .utf8)!
    }
    
    func toJSON() -> Data {
        let jsonData = try! JSONEncoder().encode(self)
        return jsonData
    }
    
}
