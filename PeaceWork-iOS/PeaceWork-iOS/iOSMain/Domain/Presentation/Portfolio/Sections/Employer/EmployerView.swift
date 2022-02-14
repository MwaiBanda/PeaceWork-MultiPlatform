//
//  EmployerView.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/10/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import PeaceWorkSDK


struct EmployerView: View {
    @Binding var postedJobs: [Job]
    @Binding var showSheet: Bool
    @State private var selectedJob: Job? = nil
    @ObservedObject var portfolioViewModel: PortfolioViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text( "Postings")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(hex: 0x333333))
                .padding(.leading, 10)
            
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(hex: Constants.DarkBlueHex))
                    .padding(.leading, 10)
                
                
                
                Text("Your Postings Are Publicly Available")
                    .foregroundColor(.gray)
                
            }
            Divider()
                .padding(.vertical, 10)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(postedJobs, id: \.id) { job in
                        PreviewCard(
                            description: job.description_,
                            compensation: job.pay,
                            payBy: job.payRate,
                            coverContent:
                                VStack(alignment: .leading){
                                    Text(job.title)
                                        .font(.title3)
                                        .bold()
                                    Text("Est. Start Date: ")
                                        .foregroundColor(.gray)
                                        .font(.caption) +
                                    Text(job.startDate)
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                    
                            }, labelContent:
                                Button { selectedJob = job } label: {
                                    
                                    Text("View More")
                                        .foregroundColor(.white)
                                        .bold()
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color(hex: Constants.DarkBlueHex))
                                        .cornerRadius(10)
                                }
                        )
                    }
                }
                .padding(.trailing)
            }
            
            
            Text("About You")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(hex: 0x333333))
                .padding([.leading, .top], 10)
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(hex: Constants.DarkBlueHex))
                    .padding(.leading, 10)
                
                
                
                Text("This Information Is Publicly Available")
                    .foregroundColor(.gray)
                
            }
            Divider()
                .padding(.top, 10)
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .padding(10)
            
            VStack(alignment: .leading, spacing: 0){
                Text("New Job Posting")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(hex: 0x333333))
                    .padding([.leading, .top], 10)
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(hex: Constants.DarkBlueHex))
                        .padding(.leading, 10)
                    
                    
                    Text("Your Posting Will Be Publicly Available")
                        .foregroundColor(.gray)
                    
                }
                Divider()
                    .padding(.vertical)
                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(hex: Constants.LightGrayHex))
                        .shadow(radius: 3)
                    
                    VStack {
                        
                        
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                        
                        
                        Button { showSheet.toggle() } label: {
                            VStack {
                                Text("Create")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: Constants.DarkBlueHex))
                                    .cornerRadius(10)
                                
                            }
                        }.padding(.top, 15)
                        Spacer()
                        
                    }.padding(10)
                    
                }
                .sheet(item: $selectedJob) { job in
                    ZStack {
                        Color(hex: Constants.OffWhiteHex).ignoresSafeArea(.all)
                        JobCardView(job: job, postedJobs: $postedJobs, portfolioViewModel: portfolioViewModel)
                    }
                }
                .padding([.leading,.vertical], 10)
                .frame(width: screenBounds.width - 10, height: 195, alignment: .center)
                
            }
        }
    }
}


extension Job: Identifiable {
    
}
