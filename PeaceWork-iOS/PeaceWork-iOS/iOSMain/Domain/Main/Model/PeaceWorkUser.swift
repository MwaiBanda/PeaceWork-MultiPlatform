//
//  PeaceWorkUser.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/27/21.
//

import Foundation
import FirebaseAuth
import FirebaseAnalytics

struct PeaceWorkUser {
    private(set) var userID: String
    private(set) var email: String?
    private var user: User?
    
    init(email: String?) {
        self.user = Auth.auth().currentUser
        self.userID = user?.uid ?? ""
        self.email = email

        Analytics.setUserID(userID)
    }
   
  
    var fullname: String {UserDefaults.standard.string(forKey: Constants.FullnameKey) ?? "User"  }
    var phoneNumber: String { UserDefaults.standard.string(forKey: Constants.PhoneKey) ?? "" }
    
 
}
