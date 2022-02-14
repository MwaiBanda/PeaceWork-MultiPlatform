//
//  Section1.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/6/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import Sliders


struct JobQuestionSection: View {
    @Binding var jobTitle : String
    @Binding var compensation : String
    @Binding var compensationSlider : Int
    @Binding var selectedLocationOption: Location
    @Binding var selectedRangeOption: PayRange
    var rangeOptions: [PayRange] = [
        .payPerDay,
        .payPerHour,
        .payPerMonth,
        .payPerRange
    ]
    var locationsOptions: [Location] = [
        .SingleLocation,
        .MultipleLocations,
        .Remote
    ]
    @State private var range = 0.0...1.0
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            DefaultTextfield(title: "Job Title", icon: "square.text.square", text: $jobTitle)
                .padding(.horizontal)
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "location.viewfinder")
                    Text("Location")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                VStack(alignment: .leading) {
                    ForEach(locationsOptions, id: \.self) { locationsOption in
                        CheckLabelToggle(text: locationsOption.rawValue, isSelected: .constant(selectedLocationOption == locationsOption) ){
                            selectedLocationOption = locationsOption
                        }
                    }
                }.padding(.horizontal)

            }
            PlainExpandableCard(coverContent: {
                HStack {
                    Image(systemName: "dollarsign.circle")
                    Text("Compensation")
                }
                .foregroundColor(.gray)
            }) { isExpanded in
                Image(systemName: isExpanded.wrappedValue ? "chevron.up":"chevron.down")
                    .foregroundColor(.gray)
            } innerContent: {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Select to Change Pay Range".uppercased())
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

