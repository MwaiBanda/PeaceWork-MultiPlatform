//
//  ReelQuestionSection.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/28/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import Sliders
import Introspect
struct ReelQuestionSection: View {
    @Binding var reelTitle : String
    @Binding var compensation : String
    @Binding var compensationSlider : Int
    @Binding var description: String
    @Binding var selectedRangeOption: PayRange
    @State private var range = 0.0...1.0
    var rangeOptions: [PayRange] = [
        .payPerDay,
        .payPerHour,
        .payPerMonth,
        .payPerRange
    ]
      var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DefaultTextfield(title: "Reel Title", icon: "square.text.square", text: $reelTitle)
                .padding(.horizontal)
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "note.text")
                    Text("Cover Description")
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
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "dollarsign.circle")
                    Text("Est. Budget")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Select Change Pay Range".uppercased())
                            .foregroundColor(.gray)
                            .font(.caption)
                        Spacer()
                        Menu {
                            Picker(selection: $selectedRangeOption, label: Text("Sorting options")) {
                                ForEach(rangeOptions, id: \.self) { rangeOption in
                                    Text("Per \(rangeOption.identifier)")
                                        .tag(rangeOption)
                                }
                            }
                            .accentColor(.gray)
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.black)
                                .offset(x: 2)
                        }
                    }
                    .padding(.horizontal)
                    .padding()
                    Divider()
                    if selectedRangeOption == .payPerRange {
                        
                        HStack(alignment: .lastTextBaseline) {
                            Text("Estimate For This Posting").font(.subheadline)
                                .fontWeight(.light)
                            Spacer()
                            VStack(alignment: .trailing) {
                            Text("Range ZMW\(Int(range.lowerBound * 1000000)) ")
                                Text(" ZMW\(Int(range.upperBound * 1000000))")
                            }                                      .font(.caption)

                        }.padding(.horizontal)
                        RangeSlider(range: $range, step: 0.0005)
                            .rangeSliderStyle(
                                   HorizontalRangeSliderStyle(
                                       track:
                                           HorizontalRangeTrack(
                                               view: Capsule().foregroundColor(Color(hex: Constants.DarkBlueHex))
                                           )
                                           .background(Capsule().foregroundColor(Color(hex: Constants.DarkBlueHex).opacity(0.25)))
                                           .frame(height: 5),
                                       lowerThumb: Circle().foregroundColor(Color(hex: Constants.DarkBlueHex))
                                        .shadow(color: Color(.black).opacity(0.2), radius: 3, x: 0, y: 0)
,
                                       upperThumb: Circle().foregroundColor(Color(hex: Constants.DarkBlueHex))                                    .shadow(color: Color(.black).opacity(0.2), radius: 3, x: 0, y: 0)
,
                                       lowerThumbSize: CGSize(width: 32, height: 32),
                                       upperThumbSize: CGSize(width: 32, height: 32),
                                       options: .forceAdjacentValue
                                   )
                               )
                            .padding(.horizontal)
                    } else {
                    DefaultTextfield(title: "Est. Compensation \(selectedRangeOption.identifier)", icon: "banknote", text: $compensation)
                        .padding(.horizontal)
                    }
                }
            }
            Spacer()
        }
    }
}

