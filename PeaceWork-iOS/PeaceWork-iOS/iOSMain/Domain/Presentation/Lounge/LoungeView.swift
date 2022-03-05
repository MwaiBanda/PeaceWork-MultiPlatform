//
//  Lounge.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/17/21.
//

import SwiftUI
import PeaceWorkSDK
struct LoungeView: View {
    @StateObject var loungeViewModel = LoungeViewModel()
    @EnvironmentObject var session: Session
    var body: some View {
        VStack {
            HStack(alignment: .lastTextBaseline) {
                VStack(alignment: .leading){
                    Text("Hello")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color(.gray))
                        .padding(.top, 20)
                    Text(session.fullname.split(separator: " ").first ?? "")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color(hex: 0x333333))


                }
                .padding(.leading)
                Spacer()
                
                
            }
            HStack(alignment: .center) {
                Text("Tap Actions To Expand & Filter Contacts")
                    .font(.subheadline)
                    .foregroundColor(Color(.gray))
                    .padding(.leading)
                Spacer()
                HStack(spacing: 0){
                    Button(action: {}){
                        Image(systemName: "slider.horizontal.below.rectangle")
                            .imageScale(.large)
                            .foregroundColor(Color(hex: Constants.DarkBlueHex))
                            .padding(.horizontal)
                    }.offset(x: 15)
                Button(action: {}){
                    Image(systemName: "slider.horizontal.3")
                        .imageScale(.large)
                        .foregroundColor(Color(hex: Constants.DarkBlueHex))
                        .padding(.horizontal)
                }
                }
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(0..<10){ i in
                        VStack {
                            Circle()
                                .frame(width: 82, height: 82)
                                .foregroundColor(Color(.lightGray))
                            Text("User")
                                .foregroundColor(Color(hex: 0x333333))
                                .fontWeight(.medium)


                        }
                        

                    }
                }
                .padding(.horizontal, 10)
                
            }
            Divider()
            HStack {
                VStack(alignment: .leading){
                    
                    Text("Messages")
                        .font(.title)
                        .fontWeight(.heavy)
                        .foregroundColor(Color(hex: 0x5A5A5A))
                    Text("Recents")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.gray))
                }
                .padding(.leading)
                Spacer()
                Button(action: {}){
                    Image(systemName: "slider.horizontal.3")
                        .imageScale(.large)
                        .foregroundColor(Color(hex: Constants.DarkBlueHex))
                        .padding(.horizontal)
                }.offset(y: -10)
                
            }
            Divider()
            ForEach(loungeViewModel.conversations, id: \.id){ conversation in
                NavigationLink {
                    ConservationCenterView(loungeViewModel: loungeViewModel, conversation: conversation)
                } label: {
                    
                    HStack(alignment: .center) {
                        Circle()
                            .frame(width: 72, height: 72)
                            .foregroundColor(Color(.lightGray))

                        VStack(alignment: .leading) {
                            Text(conversation.participants.first(where: { participant in
                                return participant.userId != session.currentUser?.userID ?? ""
                            })?.username ?? "")
                                .fontWeight(.heavy)
                                .foregroundColor(Color(hex: 0x333333))
                            Text(conversation.lastSent.message)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                            
                        }
                    
                        Spacer()
                        VStack {
                            Spacer()

                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color(hex: Constants.DarkBlueHex))

                        Text("2mins")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundColor(.gray)
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .overlay(
                               Capsule()
                                .stroke(Color.gray, lineWidth: 1.5)
                           )
                        .padding(.leading, 1)
                        .scaleEffect(0.8)
                            Spacer()

                        }
                        
                    }
                    .padding(.horizontal)
                }

                Divider()
                

            }
            Spacer()
        }.onFirstAppear {
                DispatchQueue.main.async {
                    loungeViewModel.fetchConversations(id: session.currentUser?.userID ?? "")
                    
                }
            }
        }

}

struct Lounge_Previews: PreviewProvider {
    static var previews: some View {
        LoungeView()
    }
}
