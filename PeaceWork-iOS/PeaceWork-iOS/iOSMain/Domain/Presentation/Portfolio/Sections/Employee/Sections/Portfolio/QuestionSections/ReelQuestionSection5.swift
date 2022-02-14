//
//  ReelQuestionSection5.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/29/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct ReelQuestionSection5: View {
    @Binding var isSuccessful: Bool
    @Binding var isUpdatingJob: Bool
    
    var body: some View {
        ZStack {
            
            if isSuccessful {
                VStack {
                    LottieView(name: "postSuccess", loopMode: .loop, alignment: .scaleAspectFit)
                        .frame(width: 200, height: 200, alignment: .center)
                    
                    Text("""
            Your Job has been \(isUpdatingJob ? "updated" : "posted") successfully.
            For more details. Check the Postings
            section to see or edit previous jobs,
            in the Portfolio tab.
            """)
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .frame(maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                        .padding()
                        .padding(.bottom)
                    Spacer()
                }
            } else {
                Indicator()
                    .accentColor(Color(hex: Constants.DarkBlueHex))
            }
        }
    }
}

