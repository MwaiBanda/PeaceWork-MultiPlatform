//
//  DefaultTextfield.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/16/21.
//

import SwiftUI

struct DefaultTextfield: View {
    var title: String
    var icon: String
    @Binding var text: String
    var body: some View {
        TextField(title, text: $text)
            .textContentType(.username)
            .disableAutocorrection(true)
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .padding(.leading, 24)
            .padding(15)
            .foregroundColor(Color.black)
            .cornerRadius(7)
            .disableAutocorrection(false)
            .overlay(
                HStack{
                    Image(systemName: icon)
                    Spacer()
                }
                .padding(.horizontal, 12)
                    .foregroundColor(Color.gray)
                
            )
            .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct DefaultTextfield_Previews: PreviewProvider {
    static var previews: some View {
        DefaultTextfield(title: "Email", icon: "envelope", text: .constant(""))
    }
}
