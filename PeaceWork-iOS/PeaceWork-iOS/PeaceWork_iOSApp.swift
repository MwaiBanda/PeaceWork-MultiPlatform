//
//  PeaceWork_iOSApp.swift
//  PeaceWork-iOS
//
//  Created by Mwai Banda on 2/12/22.
//

import SwiftUI
import Firebase
import PeaceWorkSDK

@main
struct iOSApp: App {
    init(){
        FirebaseApp.configure()
        DependencyRegistryKt.doInitKoin()
        DependencyRegistry.injectDependencies()
    }
    @StateObject private var session = Session()
    var body: some Scene {
        WindowGroup {
            PeaceWorkEntry(session: session)
        }
    }
}
