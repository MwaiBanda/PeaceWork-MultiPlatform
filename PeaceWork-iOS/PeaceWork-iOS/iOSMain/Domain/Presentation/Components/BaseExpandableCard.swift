//
//  ExpandableCard.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/23/21.
//

import SwiftUI

struct BaseExpandableCard<
    CoverContent: View,
    CoverIcon: View,
    InnerContent: View,
    InnerLabel: View
>: View {
    var isExpanded: Binding<Bool>
    var coverContent: () -> (CoverContent)
    var coverIcon: (Binding<Bool>) -> (CoverIcon)
    var innerContent: () -> (InnerContent)
    var onCoverClick: () -> Void
    var onInnerLabelClick: () -> Void
    var innerLabel: () -> (InnerLabel)
    
    
    var body: some View {
        ZStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.white)
                    .shadow(radius: isExpanded.wrappedValue ? 3 : 0)
                if isExpanded.wrappedValue {
                    VStack {
                        ScrollView {
                            innerContent()
                        }
                        Divider()
                        Button {
                            onInnerLabelClick()
                        } label: {
                            innerLabel()
                        }
                    }
                    .padding(.vertical,10)
                    .padding(.top, isExpanded.wrappedValue ? 80 : 0)
                }
            }
            .frame(width: screenBounds.width - 15, height: isExpanded.wrappedValue ? 350 : 20, alignment: .bottom)
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(hex: Constants.LightGrayHex))
                    .shadow(radius:  isExpanded.wrappedValue ? 0 : 2)
                
                VStack {
                    HStack(alignment: .center) {
                        coverContent()
                        Spacer()
                        HStack(spacing: 0) {
                            Button {
                                withAnimation(.easeInOut(duration: 0.35)){
                                    onCoverClick()
                                }
                            } label: {
                                coverIcon(isExpanded)
                            }
                        }
                    }
                }
                .padding(10)
            }
            .frame(width: screenBounds.width - 15, height: 80, alignment: .top)
            .onTapGesture {
                withAnimation(.easeInOut) {
                    onCoverClick()
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .padding(.top, 20)
    }
}

