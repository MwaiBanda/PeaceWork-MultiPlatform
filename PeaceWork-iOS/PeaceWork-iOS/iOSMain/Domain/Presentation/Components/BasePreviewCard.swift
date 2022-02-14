//
//  BasePreviewCard.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/17/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct BasePreviewCard <CoverContent: View, LabelContent: View, InnerContent: View>: View {
    
    var description: String
    var compensation: String
    var payBy: String
    var coverContent: CoverContent
    var innerContent: InnerContent
    var labelContent: LabelContent
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color(hex: Constants.LightGrayHex))
                .shadow(radius: 2)
            
            VStack(spacing: 0) {
                
                HStack(alignment: .center) {
                    Circle()
                        .frame(width: 72, height: 72)
                        .foregroundColor(Color( .lightGray))
                    HStack(alignment: .firstTextBaseline) {
                        coverContent
                        Spacer()
                        HStack(spacing: 0) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            Text("3.5")
                                .fontWeight(.heavy)
                                .foregroundColor(.gray)
                        }
                    }
                }           .padding(.horizontal, 10)
                    .padding(.vertical, 10)

                Divider()
                Spacer()

               
                   VStack(alignment: .leading) {
                      
               innerContent
                   Spacer()
                   }
               .padding(.horizontal, 10)

                Spacer()
                Divider()

                Button { } label: {
                    VStack {
                        labelContent
                    }
                }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)

            }
            }
        .padding([.leading,.vertical], 10)
        .frame(maxWidth: screenBounds.width - 65, minHeight: 283, maxHeight: .infinity, alignment: .leading)
    }
}

