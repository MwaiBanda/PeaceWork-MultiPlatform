//
//  PeaceWorkApp.swift
//  Shared
//
//  Created by Mwai Banda on 12/15/21.
//
import Firebase
import SwiftUI

@main
struct PeaceWorkApp: App {
    init(){
        FirebaseApp.configure()
        DependencyRegistry.injectDependencies()
    }
    @StateObject private var session = Session()
    var body: some Scene {
        WindowGroup {
            PeaceWorkEntry(session: session)
        }
    }
}
