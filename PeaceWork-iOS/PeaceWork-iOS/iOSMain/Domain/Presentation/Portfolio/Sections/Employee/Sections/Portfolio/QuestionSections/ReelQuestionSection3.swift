//
//  ReelQuestionSection3.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/29/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import Introspect

struct ReelQuestionSection3: View {
    @Binding var firstDescription: String
    @Binding var secondDescription: String
    @Binding var thirdDescription: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "square.text.square")
                    Text("First Description")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                
                VStack(alignment: .leading) {
              

                    TextEditor(text: $firstDescription)
                        .frame(minHeight: 180, maxHeight: 180)
                        .foregroundColor(.black)
                        .onChange(of: firstDescription) { [firstDescription] newText in
                            if newText.suffix(1) == "\n" && newText > firstDescription {
                                self.firstDescription.append("\u{2022} ")
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
                    Image(systemName: "square.text.square")
                    Text("Second Description")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                
                VStack(alignment: .leading) {
              

                    TextEditor(text: $secondDescription)
                        .frame(minHeight: 180, maxHeight: 180)
                        .foregroundColor(.black)
                        .onChange(of: secondDescription) { [secondDescription] newText in
                            if newText.suffix(1) == "\n" && newText > secondDescription {
                                self.secondDescription.append("\u{2022} ")
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
                    Image(systemName: "square.text.square")
                    Text("Third Description")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                
                VStack(alignment: .leading) {
              

                    TextEditor(text: $thirdDescription)
                        .frame(minHeight: 180, maxHeight: 180)
                        .foregroundColor(.black)
                        .onChange(of: thirdDescription) { [thirdDescription] newText in
                            if newText.suffix(1) == "\n" && newText > thirdDescription {
                                self.thirdDescription.append("\u{2022} ")
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
