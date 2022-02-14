//
//  EmployeeView.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/10/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct EmployeeView: View {
    @Binding var showSheet: Bool
    let tabs = ["note.text", "pencil.slash", "person.text.rectangle"]
    var body: some View {
        VStack {
            Divider()
            HorizontalTabLayout(tabs: tabs){ page in
                VStack {
                    switch(page) {
                    case 0:
                        PortfolioSection(showSheet: $showSheet)
                    case 1:
                        PostsSections()
                    case 2:
                        FollowersSection()
                    default:
                        Text("You shouldn't be seeing this")
                    }
                }
            }
        }
    }
}
