//
//  AuthWrapperView.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/16/21.
//

import SwiftUI

struct AuthBackButtonView<Content: View>: View {
    var currentOption: Binding<LoginOption>
    var content: () -> (Content)
    
    init(
        currentOption: Binding<LoginOption>,
        @ViewBuilder content: @escaping () -> (Content)
        
    ){
        self.content = content
        self.currentOption = currentOption
    }
    var body: some View {
        VStack{
            ZStack {
                content()
                if currentOption.wrappedValue == .Signup || currentOption.wrappedValue == .Login {
                    VStack {
                        Button(action: {
                            withAnimation(.easeIn) {
                                currentOption.wrappedValue = .AuthController
                            }
                        }
                        ){
                            VStack {
                                HStack(spacing: 0) {
                                    Image(systemName: "arrow.left")
                                        .foregroundColor(Color(hex: Constants.DarkBlueHex))
                                    Text("Back")
                                        .foregroundColor(Color(hex: Constants.DarkBlueHex))
                                    Spacer()
                                }
                                .padding(.leading)
                                Spacer()
                            }
                        }
                    }
                }
            }
        }
    }
}

struct AuthWrapperView_Previews: PreviewProvider {
    static var previews: some View {
        AuthBackButtonView(currentOption: .constant(.Signup)){
            Text("Login")
        }
    }
}
