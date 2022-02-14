//
//  PasswordTextfield.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/17/21.
//

import SwiftUI

struct PasswordTextfield: View {
    @State private var showPassword = false
    @Binding var password: String
    var placeholder: String
    var onCommit: () -> Void
    var body: some View {
        ZStack {
            if showPassword {
                TextField(placeholder ,text: $password, onCommit: onCommit)
                    .textContentType(.username)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding(.leading, 24)
                    .padding(15)
                    .foregroundColor(Color.black)
                    .disableAutocorrection(false)
            } else {
                SecureField(placeholder, text: $password, onCommit: onCommit)
                    .padding(.leading, 24)
                    .padding(15)
                    .padding(.bottom, 1)
            }
            HStack {
                Spacer()
                Button(action: {
                    showPassword.toggle()
                }) {
                    Image(systemName: self.showPassword ? "eye" : "eye.slash" )
                        .foregroundColor(.gray)
                }
                
            }
        }
        .overlay(
            HStack{
                Image(systemName: "lock")
                Spacer()
            }
            .padding(.horizontal, 12)
                .foregroundColor(Color.gray)
            
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .padding()
    }
}


struct PasswordTextfield_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextfield(password: .constant(""), placeholder: "Password", onCommit: {})
    }
}
