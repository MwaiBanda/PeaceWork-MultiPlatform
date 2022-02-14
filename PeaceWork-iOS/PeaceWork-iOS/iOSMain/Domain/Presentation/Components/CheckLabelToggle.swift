//
//  ClickLabel.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/4/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct CheckLabelToggle: View {
    var text: String
    var isSelected: Binding<Bool>
    var onLabelClick: () -> Void
    var body: some View {
        HStack(alignment: .center) {
            Text(text)
                .font(.headline)
            Spacer()
            Button {
                isSelected.wrappedValue.toggle()
                onLabelClick()
            } label: {
                Image(systemName:isSelected.wrappedValue ? "checkmark.circle.fill" : "checkmark.circle")
                    .imageScale(.large)
                    .foregroundColor(.gray)
                    .offset(x: 5)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
        .onTapGesture {
            isSelected.wrappedValue.toggle()
            onLabelClick()
        }
    }
}

