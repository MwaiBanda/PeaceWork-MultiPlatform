//
//  SignupView.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/16/21.
//

import SwiftUI

struct SignupView: View {
    var onSignupSuccess: (Bool) -> Void
    @StateObject private var authViewModel = AuthViewModel()
    @StateObject var viewModel = LoungeViewModel()
    @State private var isExpanded = false
    @State private var isExpanded2 = false

    @State private var company = String()
    @State private var company2 = String()

    @State private var currentPosition = String()
    @State private var currentPosition2 = String()

    @State private var dateStarted = String()
    @State private var dateStarted2 = String()

    @State private var currentPage = 0
    @EnvironmentObject var session: Session
    

    init(
        onSignupSuccess: @escaping (Bool) -> Void
    ){
        self.onSignupSuccess = onSignupSuccess
        UITabBar.appearance().backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        UITabBar.appearance().barTintColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)

    }
    
    var body: some View {
        VStack {
            TabView(selection: $currentPage) {
                
              
                    
            VStack{
                DefaultTextfield(title: "Fullname", icon: "person", text: session.$fullname)
                    .padding()
            Divider()
            DefaultTextfield(title: "Email", icon: "envelope", text: session.$email)
                    .padding()
            Divider()
                PasswordTextfield(password: session.$password, placeholder: "Password", onCommit: {})
            Divider()
                DefaultTextfield(title: "Phone", icon: "phone", text: session.$phone)
                    .padding()
            Divider()
            }.background(Color(hex: Constants.OffWhiteHex).ignoresSafeArea(.all)).tag(0)

                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                    
                 Text("We'll require a little more Information to")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .bold()
                Text("Get You Started!")
                        .font(.title2)
                        .foregroundColor(.gray)
                        .bold()
                    }.padding(.horizontal ,10)
                    Divider()
                    ScrollView{

                    BaseExpandableCard(isExpanded: $isExpanded, coverContent: {
                        HStack(alignment: .center) {
                          
                            
                            VStack(alignment: .leading) {
                                Text("Employer")
                                    .font(.title3)
                                    .bold()
                                Text("Select If You're An Employer")
                                    .foregroundColor(.gray)
                            }
                        }
                    }, coverIcon: { isExpanded in
                        Image(systemName: isExpanded.wrappedValue ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(Color(hex: Constants.DarkBlueHex))
                            .font(.title)
                            .imageScale(.large)
                        
                    }, innerContent: {
                        VStack {
                            DefaultTextfield(title: "Company", icon: "building.2", text: $company)
                            Divider()
                            DefaultTextfield(title: "Current Position", icon: "person.fill.checkmark", text: $currentPosition)
                            Divider()
                            DefaultTextfield(title: "Date Started", icon: "calendar.badge.clock", text: $dateStarted)
                            
                        }
                        
                    }, onCoverClick: {
                        isExpanded.toggle()
                        if isExpanded {
                            session.isJobSeeker = false
                        }
                        isExpanded2 = false
                    },  onInnerLabelClick: {
                        session.company = company
                        session.currentPosition = currentPosition
                        session.dateStarted = dateStarted
                        if currentPage > 0 {
                        DispatchQueue.main.async {
                            
                            authViewModel.signUpWithEmail(email: session.email, password: session.password) { signRes in
                                authViewModel.postNewUser(
                                    createdOn: SessionTime.sharedInstance.getTime(format: .yyyy_dd_MM_hh_mm),
                                    fullname: session.fullname,
                                    email: session.email,
                                    userID:  session.currentUser?.userID ?? "",
                                    company: session.company,
                                    position: session.currentPosition,
                                    dateStarted: session.dateStarted
                                ) { _, err in
                                    if err != nil {
                                        print(err?.localizedDescription ?? "")
                                    }
                                }
                            }
                        }
                        }
                    }){
                        Text("Next")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                    }

                    
                    BaseExpandableCard(isExpanded: $isExpanded2, coverContent: {
                        HStack(alignment: .center) {
                         
                            
                            VStack(alignment: .leading) {
                                Text("Job Seeker")
                                    .font(.title3)
                                    .bold()
                                Text("Select If You're Potential Talent")
                                    .foregroundColor(.gray)
                            }
                        }
                    }, coverIcon: { isExpanded in
                        Image(systemName: isExpanded.wrappedValue ? "checkmark.circle.fill" : "checkmark.circle")
                            .foregroundColor(Color(hex: Constants.DarkBlueHex))
                            .font(.title)
                            .imageScale(.large)
                        
                    }, innerContent: {
                        VStack {
                            DefaultTextfield(title: "Company", icon: "building.2", text: $company2)
                            Divider()
                            DefaultTextfield(title: "Current Position", icon: "person.fill.checkmark", text: $currentPosition2)
                            Divider()
                            DefaultTextfield(title: "Date Started", icon: "calendar.badge.clock", text: $dateStarted2)
                        }
                        
                    }, onCoverClick: {
                        isExpanded2.toggle()
                        if isExpanded2 {
                            session.isJobSeeker = true
                        }
                        isExpanded = false
                    },  onInnerLabelClick: {
                        session.company = company2
                        session.currentPosition = currentPosition2
                        session.dateStarted = dateStarted2
                        if currentPage > 0 {
                        DispatchQueue.main.async {
                            
                            authViewModel.signUpWithEmail(email: session.email, password: session.password) { signRes in
                                authViewModel.postNewUser(
                                    createdOn: SessionTime.sharedInstance.getTime(format: .yyyy_dd_MM_hh_mm),
                                    fullname: session.fullname,
                                    email: session.email,
                                    userID:  session.currentUser?.userID ?? "",
                                    company: session.company,
                                    position: session.currentPosition,
                                    dateStarted: session.dateStarted
                                ) { _, err in
                                    if err != nil {
                                        print(err?.localizedDescription ?? "")
                                    }
                                }
                            }
                        }
                        }
                    }){
                        Text("Next")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                    }
                }.background(Color(hex: Constants.OffWhiteHex).ignoresSafeArea(.all)).tag(1)
                
            }.frame(minHeight:currentPage < 1 ? 400 : 500)

            if currentPage < 1 {

            Button(action: {
                if currentPage > 0 {
                DispatchQueue.main.async {
                    
                    authViewModel.signUpWithEmail(email: session.email, password: session.password) { signRes in
                        authViewModel.postNewUser(
                            createdOn: SessionTime.sharedInstance.getTime(format: .yyyy_dd_MM_hh_mm),
                            fullname: session.fullname,
                            email: session.email,
                            userID:  session.currentUser?.userID ?? "",
                            company: session.company,
                            position: session.currentPosition,
                            dateStarted: session.dateStarted
                        ) { _, err in
                            if err != nil {
                                print(err?.localizedDescription ?? "")
                            }
                        }
                    }
                }
                } else {
                    currentPage += 1
                }
            }) {
                Text("Signup")
                    .fontWeight(.semibold)
                    .foregroundColor(
                        Color(hex:Constants.OffWhiteHex)
                    )
                    .padding(14)
            }
            .frame(maxWidth: screenBounds.width - 30)
            .background(
                Color(hex: Constants.DarkBlueHex)
            )
            .cornerRadius(10)
            .padding(.vertical, 30)
            }
            Spacer()
        }
       
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView(onSignupSuccess: {_ in})
    }
}
