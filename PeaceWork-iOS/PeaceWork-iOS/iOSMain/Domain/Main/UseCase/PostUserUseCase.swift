//
//  PostUserUsecase.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/27/21.
//

import Foundation

struct PostUserUseCase {
    @Inject private var authRepositoryImplementation: AuthRepositoryImplementation
    func execute(userData: [String: Any]){
//        authRepositoryImplementation.postUser(userData: userData)
    }
    private init(){ }
    static var sharedInstance = PostUserUseCase()
}
