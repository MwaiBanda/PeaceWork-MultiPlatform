//
//  ReelQuestionSection2.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/29/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import Introspect
import Photos
import Algorithms

struct ReelQuestionSection2: View {
    @Binding var description: String
    @Binding var showImages: Bool
    @Binding var selected : [UIImage]
    @State private var disabled = false
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PlainExpandableCard(contentHeight: 350 ,coverContent: {
                HStack {
                    Image(systemName: "note.text")
                    Text("Pick Images")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                VStack {
                    GeometryReader{_ in
                        VStack{
                            if !self.selected.isEmpty{
                                VStack(alignment: .center, spacing: 10){
                                    ForEach(self.selected.chunks(ofCount: (Int(screenBounds.width) - 65) / 115) ,id: \.self){i in
                                        HStack{
                                            ForEach(i,id: \.self){j in
                                                Image(uiImage: j)
                                                    .resizable()
                                                    .frame(width: 115, height: 160)
                                                    .aspectRatio(contentMode: .fill)
                                                    .cornerRadius(10)
                                            }
                                        }
                                    }
                                }
                                .padding(.top)
                            }
                            else{
                                
                                if self.disabled{
                                    Text("Enable Photo Access In Settings")
                                }
                                if self.selected.isEmpty {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        Indicator()
                                             .accentColor(Color(hex: Constants.DarkBlueHex))
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                        }
                  }
                }.frame(height: 350)
                
            } onCoverClick: {
                showImages = true
            }
            Spacer()
        }
    }
}





