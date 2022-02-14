//
//  PortfolioView.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/17/21.
//

import SwiftUI
import PeaceWorkSDK 

struct PortfolioView: View {
    @StateObject private var portfolioViewModel = PortfolioViewModel()
    @State private var postedJobs = [Job]()
    @EnvironmentObject var session: Session
    var firstLetter: String {
        String(session.fullname.split(separator: " ").first?.first ?? "\0")
    }
    var lastName: String {
        String(session.fullname.split(separator: " ").last?.first ?? "\0")
    }
    @State private var showSheet = false
    
    private var formatter: NumberFormatter {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.maximumFractionDigits = 0
        return f
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(spacing: 0){
                ZStack {
                    Color(hex: Constants.DarkBlueHex)
                    Color(hex: Constants.OffWhiteHex)
                    Color(hex: Constants.DarkBlueHex)
                        .mask(LinearGradient(gradient: Gradient(stops: [.init(color: .clear, location: 0.2), .init(color: Color(hex: Constants.OffWhiteHex), location: 0.6)]), startPoint: .bottom, endPoint: .top))
        
                    VStack {
                        HStack {
                            ZStack {
                                Circle()
                                    .frame(width: 82, height: 82)
                                    .foregroundColor(Color(hex: Constants.DarkBlueHex))
                                    .shadow(color: Color(.black).opacity(0.2), radius: 3, x: 0, y: 0)
                                VStack {
                                    Text("\(firstLetter + lastName)" )
                                        .foregroundColor(.white)
                                        .fontWeight(.heavy)
                                        .font(.title)
                                }
                            }
                            Text(session.fullname)
                                .font(.title)
                                .fontWeight(.heavy)
                                .foregroundColor(Color(hex: Constants.OffWhiteHex))
                            Spacer()
                            
                        }
                        .offset(y: -20)
                        .padding(.leading, 10)
                    }.frame(height: 180)
                    
                }
                .frame(maxHeight: 200)
                .clipped()
                
            }
            .ignoresSafeArea(.all, edges: .top)
            VStack(alignment: .leading, spacing: 0){
                HStack {
                    VStack(alignment: .leading, spacing: 0){
                        
                        Text(session.currentPosition)
                            .fontWeight(.heavy)
                            .foregroundColor(Color(.darkGray))
                            .font(.title3)
                        Text("\(session.dateStarted) - ongoing")
                            .foregroundColor(Color(.darkGray))
                        Text("\(session.company) Inc")
                            .foregroundColor(Color(.darkGray))
                            .fontWeight(.bold)
                            .padding(.bottom, 10)
                        
                    }
                    .padding(.leading, 10)
                    Spacer()
                    Image(systemName: "doc.richtext")
                        .font(.title)
                        .imageScale(.large)
                        .padding()
                        .foregroundColor(Color(hex: Constants.DarkBlueHex))
                }
                ZStack {
                    if session.isJobSeeker {
                        EmployeeView(showSheet: $showSheet)
                    } else {
                        EmployerView(postedJobs: $postedJobs, showSheet: $showSheet, portfolioViewModel: portfolioViewModel)
                            .onFirstAppear {
                                portfolioViewModel.getJobsById(id: session.currentUser?.userID ?? "") { jobs, err in
                                    if jobs != nil {
                                        DispatchQueue.main.async {
                                            postedJobs = jobs ?? []
                                        }
                                    }
                                }
                            }
                    }
                }
            }.offset(y: -40)
        }
        .background(Color(hex: Constants.OffWhiteHex).ignoresSafeArea(.all))
        .sheet(isPresented: $showSheet) {
            ZStack {
                Color(hex: Constants.OffWhiteHex).ignoresSafeArea(.all)
                if session.isJobSeeker {
                    ReelCardView()
                } else {
                    JobCardView(postedJobs: $postedJobs, portfolioViewModel: portfolioViewModel)
                }
            }
        }
        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
    }
}
