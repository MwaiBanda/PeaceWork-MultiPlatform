//
//  PostsSections.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/15/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct PostsSections: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Posts" )
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
            Divider()
                .padding(.vertical, 10)
        }
    }
}

struct PostsSections_Previews: PreviewProvider {
    static var previews: some View {
        PostsSections()
    }
}
