//
//  ExpandableCard.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/4/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct ExpandableCard<
    CoverContent: View,
    CoverIcon: View,
    InnerContent: View,
    InnerLabel: View
>: View {
    @State private var isExpanded = false
    var coverContent: () -> (CoverContent)
    var coverIcon: (Binding<Bool>) -> (CoverIcon)
    var innerContent: () -> (InnerContent)
    var onInnerLabelClick: () -> Void
    var innerLabel: () -> (InnerLabel)
    
    var body: some View {
        BaseExpandableCard(isExpanded: $isExpanded, coverContent: coverContent, coverIcon: coverIcon, innerContent: innerContent, onCoverClick: { isExpanded.toggle() }, onInnerLabelClick: onInnerLabelClick, innerLabel: innerLabel)
    }
}

