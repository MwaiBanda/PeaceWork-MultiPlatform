//
//  MessagingViewModel.swift
//  PeaceWork-iOS
//
//  Created by Mwai Banda on 2/13/22.
//

import Foundation
import PeaceWorkSDK
import Starscream

class MessagingViewModel: MessagingController ,  ObservableObject, WebSocketDelegate {
    var socket: WebSocket!
    @Published var isConnected = false
    @Published var messages: [Message] = []
    func initiateConversation(conversationId: String, username: String, onCompletion: @escaping () -> Void) {
        let base = URL(string: "ws://10.0.0.55:8080/message/\(conversationId)?userId=\(username)")
        guard let url = base else { return print("url fail") }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
            case .connected(let headers):
                isConnected = true
                print("websocket is connected: \(headers)")
            case .disconnected(let reason, let code):
                isConnected = false
                print("websocket is disconnected: \(reason) with code: \(code)")
            case .text(let string):
                print("Received text: \(string)")
                let msg = self.getMessageFromString(message: string)
            messages.append(msg)
            case .binary(let data):
                print("Received data: \(data.count)")
            case .ping(_):
                break
            case .pong(_):
                break
            case .viabilityChanged(_):
                break
            case .reconnectSuggested(_):
                break
            case .cancelled:
                isConnected = false
            case .error(let error):
                isConnected = false
            print(error?.localizedDescription ?? "")
            }
    }
   
    func sentText(message: String, onCompletion: @escaping (String) -> Void){
        socket.write(string: message)
        onCompletion("")
    }
    
    func getAllMessages(conversationID: String, onCompletion: @escaping () -> Void) {
        getAllConversationMessages(conversationId: conversationID) { [weak self] msgs, err in
            if msgs != nil {
                self?.messages = msgs ?? []
                onCompletion()
            }
        }
    }
   
    override init() {
        super.init()
    }
}
