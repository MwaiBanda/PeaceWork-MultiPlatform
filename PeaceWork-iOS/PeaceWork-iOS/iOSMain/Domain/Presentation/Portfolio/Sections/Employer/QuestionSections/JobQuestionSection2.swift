//
//  EmployerSection2.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/6/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import Introspect


struct JobQuestionSection2: View {
    @Binding var description: String
    @Binding var selectedEmploymentTypeOption: EmploymentType
    @Binding var selectedJobTypeOption: JobType
    var jobTypeOptions: [JobType] = [
        .FullTime,
        .PartTime,
        .Either
    ]
    var employmentTypeOptions: [EmploymentType] = [
        .Contract,
        .Temporary,
        .Internship
    ]
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "person.badge.clock")
                    Text("Work Requirements")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                VStack(alignment: .leading) {
                    ForEach(jobTypeOptions, id: \.self) { jobTypeOption in
                        CheckLabelToggle(text: jobTypeOption.identifier, isSelected: .constant(selectedJobTypeOption == jobTypeOption)){
                           selectedJobTypeOption = jobTypeOption
                        }
                    }
                }.padding(.horizontal)
            }
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "personalhotspot")
                    Text("Employment Type")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                VStack(alignment: .leading) {
                    ForEach(employmentTypeOptions, id: \.self){ employmentTypeOption in
                        CheckLabelToggle(text: employmentTypeOption.identifier, isSelected: .constant(selectedEmploymentTypeOption == employmentTypeOption)){
                            selectedEmploymentTypeOption = employmentTypeOption
                        }
                    }
                }.padding(.horizontal)
            }
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "note.text")
                    Text("Description")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                
                VStack(alignment: .leading) {
                    TextEditor(text: $description)
                        .frame(minHeight: 180, maxHeight: 180)
                        .foregroundColor(.black)
                        .onChange(of: description) { [description] newText in
                            if newText.suffix(1) == "\n" && newText > description {
                                self.description.append("\u{2022} ")
                            }
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .introspectTextView { textView in
                            textView.backgroundColor = UIColor.init(.clear)
                        }
                    }
            }
            Spacer()
        }
    }
}

