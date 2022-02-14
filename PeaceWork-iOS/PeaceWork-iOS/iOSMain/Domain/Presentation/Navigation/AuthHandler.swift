//
//  AuthHandler.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/17/21.
//

import SwiftUI

struct AuthHandler<Content: View>: View {
    var content: () -> (Content)
    @ObservedObject var session: Session
    
    init(session: Session, @ViewBuilder content: @escaping () -> (Content)) {
        self.content = content
        self.session = session
        self.session.listen()
    }
    
    var body: some View {
        VStack {
            ZStack {
                AuthControllerView { value in
                    session.isLoggedIn = value
                }
                if session.isLoggedIn {
                    content()
                }
            }
        }
    }
}

struct AuthHandler_Previews: PreviewProvider {
    static var previews: some View {
        AuthHandler(session: Session()) {
            BottomTabBar()
        }
        .environmentObject(Session())
    }
}
