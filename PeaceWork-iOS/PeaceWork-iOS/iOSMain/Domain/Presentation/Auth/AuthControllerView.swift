//
//  LoginView.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/16/21.
//

import SwiftUI

enum LoginOption {
    case AuthController, Login, Signup
}

struct AuthControllerView: View {
    var onLoginSuccess: (Bool) -> Void
    @EnvironmentObject var session: Session
    @StateObject private var authViewModel = AuthViewModel()

    var body: some View {
        VStack {
            ZStack {
                AuthBackButtonView(
                    currentOption: $session.option
                ) {
                    VStack {
                        Image("logo2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, 20)
                        Spacer()
                    }
                }
            }
            Spacer()
            ZStack {
                switch(session.option){
                case .AuthController:
                    VStack {
                        LoginButton
                        SignupButton
                    }
                case .Login:
                    LoginView(option: $session.option,
                        onLoginSuccess: {
                            onLoginSuccess($0)
                        }
                    )
                case .Signup:
                    SignupView(
                        onSignupSuccess: {
                            onLoginSuccess($0)
                        }
                    )
                }
            }
        }
        .background(
            Color(hex:Constants.OffWhiteHex)
                .ignoresSafeArea(.all)
        )
        
    }
    var LoginButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
            session.option = .Login
            }
        }) {
            Text("Login")
                .fontWeight(.semibold)
                .foregroundColor(Color(hex:Constants.OffWhiteHex))
                .padding(14)
        }
        .frame(maxWidth: screenBounds.width - 30)
        .background(
            Color(hex: Constants.DarkBlueHex)
        )
        .cornerRadius(10)
        .padding(.bottom, 30)
    }
    var SignupButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
            session.option = .Signup
            }
            }) {
            Text("Signup")
                .fontWeight(.semibold)
                .foregroundColor(        Color(hex:Constants.DarkBlueHex)
                )
                .padding(14)
        }
        .frame(maxWidth: screenBounds.width - 30)
        .background(
            Color(hex: Constants.OffWhiteHex)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color(hex: Constants.DarkBlueHex), lineWidth: 2)
        )
        .padding(.bottom, 13)
    }
}

struct AuthControllerView_Previews: PreviewProvider {
    static var previews: some View {
        AuthControllerView(onLoginSuccess: {_ in })
            .environmentObject(Session())
    }
}
