//
//  Dependency.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/26/21.
//

import Foundation
import FirebaseAuth

struct DependencyRegistry {
    static var injectDependencies: () -> Void = {
        Resolver.inject(Auth.auth() as Auth)
        Resolver.inject(AuthRepositoryImplementation.shardInstance)
        Resolver.inject(SignInUseCase.sharedInstance)
        Resolver.inject(SignUpUseCase.sharedInstance)
    }
    private init(){ }
}
