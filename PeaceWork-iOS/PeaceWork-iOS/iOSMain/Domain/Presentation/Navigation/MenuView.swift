//
//  MenuView.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/17/21.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var session: Session
    var body: some View {
        VStack {
            Image("logo2")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Text("MENU")
                    .padding(.leading, 10)
                    .foregroundColor(Color(.darkGray))
                    .font(.subheadline)
                Spacer()
            }
            Divider()
            VStack(spacing: 0) {

        MenuButton(icon: "doc.text.magnifyingglass", title: "Find Jobs", onClick: {})
        MenuButton(icon: "doc.text.magnifyingglass", title: "Company Reviews", onClick: {})
        MenuButton(icon: "doc.text.magnifyingglass", title: "Find Salaries", onClick: {})
            }
        Divider()
            HStack {
                Text("HELP & SUPPORT")
                    .padding(.leading, 10)
                    .foregroundColor(Color(.darkGray))
                    .font(.subheadline)

                Spacer()
            }
            VStack(spacing: 0) {
            MenuButton(icon: "doc.text.magnifyingglass", title: "My Jobs", onClick: {})
            MenuButton(icon: "doc.text.magnifyingglass", title: "My Reviews", onClick: {})
          
            MenuButton(icon:  "doc.text.magnifyingglass", title: "Settings", onClick: {})

            }
            Divider()
            
            Button { session.logOut() } label: {
                VStack {
                    Text("Logout")
                        .foregroundColor(.white)
                        .bold()
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: Constants.DarkBlueHex))
                        .cornerRadius(10)
                        .padding(.bottom)

                }
            }.padding(.top, 15)
                .padding(.horizontal, 10)
        
        }.foregroundColor(Color(.black))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
