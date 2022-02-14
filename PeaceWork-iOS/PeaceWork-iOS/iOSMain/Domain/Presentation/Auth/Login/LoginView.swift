//
//  LoginView.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/16/21.
//

import SwiftUI

struct LoginView: View {
    @Binding var option: LoginOption
    var onLoginSuccess: (Bool) -> Void
    @State private var email = String()
    @State private var password = String()
    @EnvironmentObject var session: Session
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            Divider()
            DefaultTextfield(title: "Email", icon: "envelope", text: $email)
                .padding()
            Divider()
            PasswordTextfield(password: $password, placeholder: "Password", onCommit: {})

            Divider()
            HStack {
                Text("Forgot Password?")
                
                Spacer()
                
            }
            .padding(.leading)
            VStack{
                Button(action: {
                    authViewModel.signInWithEmail(email: email, password: password) { email in
                        onLoginSuccess(true)
                        session.isLoggedIn = true
                        print("[EMAIL] \(email)")
                    }
                    print(session.isLoggedIn)
                }) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .foregroundColor(        Color(hex:Constants.OffWhiteHex)
                        )
                        .padding(14)
                        .frame(maxWidth: screenBounds.width - 30)

                }
                .background(
                    Color(hex: Constants.DarkBlueHex)
                )
                .cornerRadius(10)
                .padding(.vertical, 30)
                
                Button(action: {
                    option = .Signup
                }) {
                    Text("Signup")
                        .fontWeight(.semibold)
                        .foregroundColor(        Color(hex:Constants.DarkBlueHex)
                        )
                        .padding(14)
                        .frame(maxWidth: screenBounds.width - 30)
                }
                .background(
                    Color(hex: Constants.OffWhiteHex)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(hex: Constants.DarkBlueHex), lineWidth: 2)
                )
            }
            Spacer()
        }    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(option: .constant(.Signup), onLoginSuccess: { _ in })
    }
}
