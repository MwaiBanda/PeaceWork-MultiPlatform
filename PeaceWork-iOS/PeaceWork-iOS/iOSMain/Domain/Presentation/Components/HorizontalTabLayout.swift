//
//  HorizontalTabLayout.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/15/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct HorizontalTabLayout<Content: View>: View {
    @Namespace var namespace
    @State var currentTab = 0
    var tabs: [String]
    var content: (Int) -> (Content)
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 0) {
                ForEach(Array(zip(tabs.indices, tabs)), id: \.0, content: { index, tab in
                    TabItem(namespace: namespace, image: tab, currentTab: $currentTab, tab: index, onTabClick: {
                     withAnimation(.easeInOut){currentTab = index }})
                })
            }
            }
            .padding(.bottom, 10)
            content(currentTab)
            Spacer()
        }
    }
}

struct TabItem: View {
    let namespace: Namespace.ID
    var image: String
    @Binding var currentTab: Int
    var tab: Int
    var onTabClick: () -> Void
    
    var body: some View {
        Button { onTabClick() } label: {
            VStack {
                Spacer()
                Image(systemName: image)
                    .imageScale(.large)
                    .foregroundColor(Color(hex: Constants.DarkBlueHex))
                .padding()
                ZStack {
                if currentTab == tab {
                    Color(hex: Constants.DarkBlueHex)
                    .frame(width: screenBounds.width * 0.33, height: 2)
                    .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)

                } else {
                    Color.clear.frame(width: screenBounds.width * 0.33, height: 2)
                }
                Divider()
                }
            }

        }.buttonStyle(.plain)
    }
}
