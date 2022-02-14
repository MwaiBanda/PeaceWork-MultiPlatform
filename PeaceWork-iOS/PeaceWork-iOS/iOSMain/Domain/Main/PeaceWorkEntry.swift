//
//  ContentView.swift
//  Shared
//
//  Created by Mwai Banda on 12/15/21.
//

import SwiftUI
import PeaceWorkSDK 

struct PeaceWorkEntry: View {
    
    @ObservedObject var session: Session
    var body: some View {
        AuthHandler(session: session) {
            BottomTabBar()
        }
        .environmentObject(session)
    }
}

struct PeaceWorkEntry_Previews: PreviewProvider {
    static var previews: some View {
        PeaceWorkEntry(session: Session())
    }
}
