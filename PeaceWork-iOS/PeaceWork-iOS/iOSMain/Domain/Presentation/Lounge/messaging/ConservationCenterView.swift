//
//  ConservationCenterView.swift
//  PeaceWork-iOS
//
//  Created by Mwai Banda on 2/12/22.
//
import Combine
import SwiftUI
import PeaceWorkSDK

struct ConservationCenterView: View {
    @State private var message: String = ""
    @StateObject private var messagingViewModel = MessagingViewModel()
    @EnvironmentObject var session: Session
    var conversation: Conversation

    var body: some View {
        VStack(spacing: 0) {
            Divider()
                .offset(y: -20)
            ScrollView {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 10))], spacing: 0) {
                ForEach(messagingViewModel.messages, id: \.self) { i in
                    HStack {
                        ZStack {
                            Text(i.text)
                                .foregroundColor((session.currentUser?.userID ?? "") == i.username ? .white : .black)
                                .padding(.horizontal)
                                .padding(.vertical, 12)
                                .background( (session.currentUser?.userID ?? "") == i.username ? Color(hex: Constants.DarkBlueHex).opacity(0.7) : Color.black.opacity(0.2))
                                .cornerRadius(10)

                        }.frame(width: screenBounds.width * 0.7, alignment: (session.currentUser?.userID ?? "") == i.username ? .trailing : .leading)
                            .padding(.vertical,5)
//                        .background(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment:(session.currentUser?.userID ?? "") == i.username ? .trailing : .leading)
                }
            }.padding(.horizontal)
            }
            VStack(spacing: 0) {
                Divider()
                    .padding(.bottom, 10)
                HStack(alignment: .center) {
                TextField("", text: $message)
                        .background(Color.white)
                    .frame(maxWidth: .infinity)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 10)
                    
                    Spacer()
                    Button { messagingViewModel.sentText(message: message) { message = $0 } } label: {
                        Image(systemName: "paperplane.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color(hex: Constants.DarkBlueHex))
                            .padding(.trailing, 10)
                    }
                    
                }.padding(.bottom, 10)
                Divider()
                    .padding(.bottom, 10)
            }
        }.onAppear {
            DispatchQueue.main.async {
            messagingViewModel.getAllMessages(conversationID: conversation.id) {
                messagingViewModel.initiateConversation(conversationId: conversation.id, username: session.currentUser?.userID ?? "") {
                    
                }
            }
            }
        }
        .onDisappear(perform: {
            DispatchQueue.main.async {
            messagingViewModel.socket.disconnect()
            messagingViewModel.updateConversationMessages(conversationId: conversation.id, messages: messagingViewModel.messages)
            }
        })
        .background(Color(hex: Constants.OffWhiteHex).ignoresSafeArea(.all))
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                HStack(alignment: .center) {
                    Circle()
                        .frame(width: 55, height: 55)
                        .foregroundColor(Color( .lightGray))
                    HStack(alignment: .firstTextBaseline) {
                        VStack(alignment: .leading){
                            Text(conversation.participants.first(where: { i in
                                return i.id != session.currentUser?.userID ?? ""
                            })?.username ?? "")
                                .font(.title3)
                                .bold()
                            Text("Tap To View Profile")
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                        }
                        Spacer()
                        
                    }
                }           .padding(.horizontal, 10)
                    .padding(.top, 10)
            }
        }
}
}

