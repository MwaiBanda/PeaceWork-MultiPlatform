//
//  EmployerSection3.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/6/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import Introspect


struct JobQuestionSection3: View {
    @Binding var qualifications: String
    @Binding var responsibilities: String
    @Binding var estimatedStartDate: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            DefaultTextfield(title: "Est. Start Date", icon: "square.text.square", text: $estimatedStartDate)
                    .padding(.horizontal)

            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "graduationcap")
                    Text("Qualifications")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                
                VStack(alignment: .leading) {
              

                    TextEditor(text: $qualifications)
                        .frame(minHeight: 180, maxHeight: 180)
                        .foregroundColor(.black)
                        .onChange(of: qualifications) { [qualifications] newText in
                            if newText.suffix(1) == "\n" && newText > qualifications {
                                self.qualifications.append("\u{2022} ")
                            }
                        }
                        .padding(.horizontal)
                        .padding(.horizontal)
                        .introspectTextView { textView in
                            textView.backgroundColor = UIColor.init(.clear)
                        }
                    }
            }
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "greetingcard")
                    Text("Responsibilities")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                
                VStack(alignment: .leading) {
              

                    TextEditor(text: $responsibilities)
                        .frame(minHeight: 180, maxHeight: 180)
                        .foregroundColor(.black)
                        .onChange(of: responsibilities) { [responsibilities] newText in
                            if newText.suffix(1) == "\n" && newText > responsibilities {
                                self.responsibilities.append("\u{2022} ")
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
