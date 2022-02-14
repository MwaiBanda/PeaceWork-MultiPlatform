//
//  ReelQuestionSection4.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/29/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI

struct ReelQuestionSection4: View {
    @Binding var targetAudience: String
    @Binding var estimatedStartDate: String
    @Binding var estimatedCompletionDate: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DefaultTextfield(title: "Target Audience", icon: "square.text.square", text: $targetAudience)
                    .padding(.horizontal)
            Divider().padding(.vertical)
            DefaultTextfield(title: "Est. Start Date", icon: "square.text.square", text: $estimatedStartDate)
                    .padding(.horizontal)
            Divider().padding(.vertical)
            DefaultTextfield(title: "Est. Completion Date", icon: "square.text.square", text: $estimatedCompletionDate)
                    .padding(.horizontal)
            Spacer()

        }
    }
}

