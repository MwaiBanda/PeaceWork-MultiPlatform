//
//  UserDefaults+Helpers.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/27/21.
//

import Foundation


struct StoreUserDefaults {
    static let shared = StoreUserDefaults()
    
    func saveCollection<T: Encodable>(_ items: [T], key: String) {
        let data = items.map { try? JSONEncoder().encode($0) }
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func saveItem<T: Encodable>(_ item: T, key: String) {
        let object = item.toJSON()
        UserDefaults.standard.set(object, forKey: key)
    }
    
    func getItem<T: Codable>(key:String) -> T {
        let data = UserDefaults.standard.object(forKey: key)
        return data as! T
    }

    func loadCollection<T: Codable>(key: String) -> [T] {
        guard let encodedData = UserDefaults.standard.array(forKey: key) as? [Data] else {
            return []
        }

        return encodedData.map { try! JSONDecoder().decode(T.self, from: $0) }
    }
    private init() { }
}
