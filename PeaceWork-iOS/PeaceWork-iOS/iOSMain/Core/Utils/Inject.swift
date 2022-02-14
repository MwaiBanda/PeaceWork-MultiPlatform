//
//  Inject.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/26/21.
//

import Foundation

@propertyWrapper
/// Property wrapper for Dependency Injection
struct Inject<T> {
    var wrappedValue: T

    init() {
        self.wrappedValue = Resolver.resolve()
    }
}

