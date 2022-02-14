//
//  JobCard.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/4/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct PreviewCard<CoverContent: View, LabelContent: View>: View {
    
    var description: String
    var compensation: String
    var payBy: String
    var coverContent: CoverContent
    var labelContent: LabelContent
    
    
    var body: some View {
        BasePreviewCard(description: description, compensation: compensation, payBy: payBy, coverContent: coverContent, innerContent:
         HStack {
                     VStack(alignment: .leading) {
            Text(description)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxHeight: .infinity)
            Spacer()
            
            HStack {
                Image(systemName: "dollarsign.circle")
                
                Text(compensation)
                    .foregroundColor(.gray)
                    .font(.subheadline) +
                Text("ZWK \(payBy)")
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            .foregroundColor(.gray)
            .opacity(compensation.isEmpty ? 0 : 1)
            
        }; Spacer() }, labelContent: labelContent)

    }
    func attachContent<InnerContent: View>(@ViewBuilder content: @escaping () -> InnerContent) -> some View {
        BasePreviewCard(description: description, compensation: compensation, payBy: payBy, coverContent: coverContent, innerContent: content(), labelContent: labelContent)
        
    }
}

extension PreviewCard {
    init(
        description: String? = "",
        compensation: String? = "",
        payBy: String? = "",
        @ViewBuilder coverContent:  () -> CoverContent,
        @ViewBuilder labelContent:  () -> LabelContent
    ) {
        self.description = description ?? ""
        self.compensation = compensation ?? ""
        self.payBy = payBy ?? ""
        self.coverContent = coverContent()
        self.labelContent = labelContent()
    }
}

