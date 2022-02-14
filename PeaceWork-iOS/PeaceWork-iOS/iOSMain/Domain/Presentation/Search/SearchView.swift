//
//  SearchView.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/17/21.
//

import SwiftUI

struct SearchView: View {
    @State private var searchTerm = ""
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            DefaultTextfield(title: "Search", icon: "magnifyingglass", text: $searchTerm)
            Divider()
                .padding(.bottom, 10)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<10) { _ in
                        HStack {
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color(hex: Constants.DarkBlueHex))
                            Text("City")
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
                        .padding(1)
                    }
                }
                .padding(.horizontal)
            }

            Divider()
                .padding(.top, 10)
            Text("Recommended")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(hex: 0x333333))
                .padding(10)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<10) { _ in
                        PreviewCard(
                            description: "hfhfh",
                            compensation: "",
                            payBy: "",
                            coverContent: {
                            VStack(alignment: .leading){
                                Text("Company Name")
                                    .font(.title3)
                                    .bold()
                                Text("Job Position")
                                    .foregroundColor(.gray)
                                
                            }
                            }, labelContent: {
                            Text("Apply")
                                .foregroundColor(.white)
                                .bold()
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: Constants.DarkBlueHex))
                                .cornerRadius(10)
                        })
                    }
                }
                .padding(.trailing)
            }
            Text("Browse")
                .font(.title)
                .fontWeight(.heavy)
                .foregroundColor(Color(hex: 0x333333))
                .padding(10)
            Divider()
                .padding(.bottom, 30)
            
            VStack(spacing: 35) {
                ForEach(0..<8) { _ in
                    ExpandableCard(coverContent: {
                        HStack(alignment: .center) {
                            Circle()
                                .frame(width: 82, height: 82)
                                .foregroundColor(Color( .lightGray))
                            
                            VStack(alignment: .leading) {
                                Text("Company Name")
                                    .font(.title3)
                                    .bold()
                                Text("Jobs Available :: 3")
                                    .foregroundColor(.gray)
                            }
                        }
                    }, coverIcon: { isExpanded in
                        Image(systemName: isExpanded.wrappedValue ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                            .foregroundColor(Color(hex: Constants.DarkBlueHex))
                            .font(.title)
                            .imageScale(.large)
                        
                    }, innerContent: {
                        Text("Demo Content")
                        
                    }, onInnerLabelClick: { }){
                        Text("View More")
                            .foregroundColor(.black)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
