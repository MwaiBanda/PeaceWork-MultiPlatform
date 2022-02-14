//
//  Resolver.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/26/21.
//

import Foundation

final class Resolver: ObservableObject {
    private var dependencies = [String: AnyObject]()
    private static var shared = Resolver()
    
    static func inject<T>(_ dependency: T) {
        shared.inject(dependency)
    }

    static func resolve<T>() -> T {
        shared.resolve()
    }
    
    
    private func inject<T>(_ dependency: T) {
        let key = String(describing: T.self)
        dependencies[key] = dependency as AnyObject
    }

    private func resolve<T>() -> T {
        let key = String(describing: T.self)
        let dependency = dependencies[key] as? T

        assert(dependency != nil, "No dependency found of \(key)")

        return dependency!
    }
}


