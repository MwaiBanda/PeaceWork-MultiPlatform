//
//  Lounge.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/17/21.
//

import SwiftUI
import PeaceWorkSDK
struct LoungeView: View {
    @ObservedObject var loungeViewModel: LoungeViewModel
    @ObservedObject var conversationViewModel: ConversationViewModel
    @EnvironmentObject var session: Session
    /* Reminder */
    // Move to viewModel & Make Array
    var username: (String) -> (firstname: String, lastInitial: String) = { username in
        return (firstname: String(username.prefix(while: { return $0 != " " })), lastInitial: String(username.split(separator: " ").last?.first ?? "\t"))
    }
    /* Reminder */
    // Move to viewModel & Make Array
    var initials: (String) -> (firstInitial: String, lastInitial: String) = { username in
        return (firstInitial: String(username.split(separator: " ").first?.first ?? "\t"), lastInitial: String(username.split(separator: " ").last?.first ?? "\t"))
    }
    /* Reminder */
    // Move to viewModel & Make Publishable
    var participant: ( [Participant], String) -> Participant? = { participants, userID in
        return participants.first(where: { participant in
            return participant.userId != userID
        })
    }
    init (loungeViewModel: LoungeViewModel, conversationViewModel: ConversationViewModel ){
        self.loungeViewModel = loungeViewModel
        self.conversationViewModel = conversationViewModel
       
    }
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
            .onAppear {
                loungeViewModel.fetchProfile(userID: session.currentUser?.userID ?? "") { [self] userID in
                    self.conversationViewModel.fetchConversations(id: userID)
                }
            }
            ScrollView(.horizontal, showsIndicators: false){
                HStack {
                    ForEach(loungeViewModel.contacts, id: \.self){ contact in
                        Menu {
                            Button {
                                DispatchQueue.main.async {
                                    conversationViewModel.joinConversation(participants: (firstUsername: session.fullname, firstUserID: session.currentUser?.userID ?? "", SecondUsername: contact.username, SecondUserID: contact.userID)) {
                                       
                                    } }} label: {
                                        HStack {
                                            Text("Message")
                                            Spacer()
                                            Image(systemName: "envelope")
                                        }
                                    }
                            Button { } label: {
                                HStack {
                                    Text("View Profile")
                                    Spacer()
                                    Image(systemName: "person.badge.plus")
                                }
                            }
                            Button { } label: {
                                HStack {
                                    Text("Remove Contact")
                                    Spacer()
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        } label: {
                            VStack {
                                
                                ZStack {
                                    Circle()
                                        .frame(width: 72, height: 72)
                                        .foregroundColor(Color(hex: Constants.DarkBlueHex))
                                    
                                    VStack {
                                        Text("\(initials(contact.username).firstInitial )\(initials(contact.username).lastInitial)" )
                                            .foregroundColor(.white)
                                            .fontWeight(.heavy)
                                            .font(.title)
                                    }
                                }
                                Text("\(username(contact.username).firstname) \(username(contact.username).lastInitial).")
                                    .foregroundColor(Color(hex: 0x333333))
                                    .fontWeight(.medium)
                                
                                
                            }
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
                        .foregroundColor(Color(hex: 0x333333))
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
            ForEach(conversationViewModel.conversations, id: \.id){ conversation in
                NavigationLink {
                    ConservationCenterView(conversationViewModel: conversationViewModel, conversation: conversation)
                } label: {
                    
                    HStack(alignment: .center) {
                        ZStack {
                            Circle()
                                .frame(width: 72, height: 72)
                                .foregroundColor(Color(hex: Constants.DarkBlueHex))
                            
                            VStack {
                                Text("\(initials((participant(conversation.participants, session.currentUser?.userID ?? "" )?.username ?? "")).firstInitial)\(initials((participant(conversation.participants, session.currentUser?.userID ?? "" )?.username ?? "")).lastInitial)" )
                                    .foregroundColor(.white)
                                    .fontWeight(.heavy)
                                    .font(.title)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            Text(participant(conversation.participants, session.currentUser?.userID ?? "" )?.username ?? "")
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
        }
        
    }
    
}


