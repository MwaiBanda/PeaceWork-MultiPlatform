//
//  PortfolioSection.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/15/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct PortfolioSection: View {
    @Binding var showSheet: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Portfolio" )
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(hex: 0x333333))
                .padding(.leading, 10)
            
            HStack {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(hex: Constants.DarkBlueHex))
                    .padding(.leading, 10)

                Text("Your Profile Is Publicly Available")
                    .foregroundColor(.gray)
            }
                .padding(.bottom, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<10) { _ in
                        PreviewCard {
                            VStack(alignment: .leading){
                                Text("Reel Title")
                                    .font(.title3)
                                    .bold()
                                Text("Est. Start Date: ")
                                    .foregroundColor(.gray)
                                    .font(.caption) +
                                Text("12/14/2021")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                Text("Est. Completion Date: ")
                                    .foregroundColor(.gray)
                                    .font(.caption) +
                                Text("ongoing")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)                            }
                        } labelContent: {
                            Button {  } label: {
                                
                                Text("View More")
                                    .foregroundColor(.white)
                                    .bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color(hex: Constants.DarkBlueHex))
                                    .cornerRadius(10)
                            }
                        }.attachContent {
                            VStack(alignment: .leading, spacing: 0) {
                                HStack {
                                    Image(systemName: "person.3")
                                    Text("TARGET AUDIENCE: ")
                                        .foregroundColor(.gray)
                                        .font(.caption) +
                                    Text("Android, iOS & Web")
                                        .foregroundColor(.gray)
                                        .font(.subheadline)
                                  
                                }
                                .foregroundColor(.gray)
                                HStack {
                                    Image(systemName: "dollarsign.circle")
                                    
                                    Text("BUDGET: ")
                                        .foregroundColor(.gray)
                                        .font(.caption) +
                                    Text("5353")
                                        .foregroundColor(.gray)
                                        .font(.subheadline) +
                                    Text("ZWK ")
                                        .foregroundColor(.gray)
                                        .font(.caption)
                                }
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                                ScrollView(.horizontal, showsIndicators: false){
                                    HStack {
                                        ForEach(0..<5) { _ in
                                            RoundedRectangle(cornerRadius: 10)
                                                .frame(width: 200, height: 250)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                                .padding(.vertical, 10)
                            }
                        }
                        .padding(.vertical)
                    }
                }
                .padding(.trailing, 10)
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(minHeight: 600 , maxHeight: .infinity)
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

            Divider().padding(.top, 10)

            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
                .lineLimit(nil)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: .infinity)
                .padding(10)
            
            VStack(alignment: .leading, spacing: 0){
                Text("Create Reel")
                    .font(.title)
                    .fontWeight(.heavy)
                    .foregroundColor(Color(hex: 0x333333))
                    .padding([.leading, .top], 10)
                HStack {
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(Color(hex: Constants.DarkBlueHex))
                        .padding(.leading, 10)
                    
                    Text("Your Reels Is Publicly Available")
                        .foregroundColor(.gray)
                }

                Divider().padding(.vertical)

                ZStack {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(hex: Constants.LightGrayHex))
                        .shadow(radius: 3)
                    
                    VStack {
                        
                        Text("Reels allow to you to create simple well documented presentations of your work. Be Bold & Be Creative, in-order to stand out as you are.")
                        
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

                    }
                    .padding(10)
                }
                .padding([.leading,.vertical], 10)
                .frame(width: screenBounds.width - 10, height: 195, alignment: .center)
            }
        Spacer()
            
        }
    }
}
