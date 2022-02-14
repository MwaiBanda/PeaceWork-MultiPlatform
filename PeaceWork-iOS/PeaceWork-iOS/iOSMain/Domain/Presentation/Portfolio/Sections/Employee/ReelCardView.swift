//
//  ReelCardView.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/28/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import PeaceWorkSDK

struct ReelCardView: View {
    @State private var currentPage = Int()
    @EnvironmentObject var session: Session
    @State private var timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    @State private var loadingState: Double = 0
    @State private var startLoading = false
    @State private var isSuccessful = false
    @State private var isUpdatingJob = false
    @State private var isConfirmedToDelete = false
    @State private var loadingIncrement: Double = 1
    /* Section 1 State */
    @State private var reelTitle = String()
    @State private var compensation = String()
    @State private var compensationSlider = Int()
    @State private var reelHeaderDescription = "\u{2022} "
    @State private var selectedRangeOption: PayRange = .payPerMonth
    /* Section 2 State */
    @State var selectedImages : [UIImage] = []
    @State private var showPhotoPicker = false

    /* Section 3 State */
    @State private var firstDescription = "\u{2022} "
    @State private var secondDescription = "\u{2022} "
    @State private var thirdDescription = "\u{2022} "
    /* Section 4 State */
    @State private var targetAudience = String()
    @State private var estimatedStartDate = String()
    @State private var estimatedCompletionDate = String()

    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color(hex: Constants.LightGrayHex))
                    .shadow(radius: 2)
                
                VStack {
                    HStack {
                    VStack(alignment: .leading) {
                        Text(currentPage < 4 ? "Let's Get Started" : "Reel \(isUpdatingJob ? "Updated" : "Posted")")
                            .bold()
                            .font(.title2)
                        .foregroundColor(.gray)
                        Text(currentPage < 4 ?  "With \(isUpdatingJob ? "editing this" : "this new") reel" : "Congratulations!")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .bold()
                    }
                        Spacer()
                        HStack {
                            Text("\(currentPage + 1)").font(.caption) +
                            Text("/").font(.headline).fontWeight(.light) +
                            Text("4").font(.caption)
                        }.padding()
                        .foregroundColor(.gray)

                    }.padding(.vertical)
                        .padding(.leading)
                        .padding(.top)

                        if currentPage == 3 && startLoading {
                            ProgressView(value: loadingState, total: 101)
                                .progressViewStyle(LinearProgressViewStyle())
                                .accentColor(Color(hex: Constants.DarkBlueHex))
                                
                        } else {
                            if currentPage < 1 || currentPage > 2 {
                                Divider()
                            }
                        }
                    
                    TabView (selection: $currentPage) {
                        ReelQuestionSection(reelTitle: $reelTitle, compensation: $compensation, compensationSlider: $compensationSlider, description: $reelHeaderDescription,  selectedRangeOption: $selectedRangeOption)
                            .tag(0)
                        ReelQuestionSection2(description: $reelHeaderDescription, showImages: $showPhotoPicker, selected: $selectedImages)
                            .tag(1)
                            .offset(y: -20)
                        ReelQuestionSection3(firstDescription: $firstDescription, secondDescription: $secondDescription, thirdDescription: $thirdDescription)
                            .tag(2)
                            .offset(y: -20)
                        ReelQuestionSection4(targetAudience: $targetAudience, estimatedStartDate: $estimatedStartDate, estimatedCompletionDate: $estimatedCompletionDate)
                            .tag(3)
                        ReelQuestionSection5(isSuccessful: $isSuccessful, isUpdatingJob: $isUpdatingJob)
                            .tag(4)
                    }.tabViewStyle(.page(indexDisplayMode: .never))
                    
                    Divider()
                    HStack {
                        if isUpdatingJob {
                            Button {
                            } label: {
                                Image(systemName: "trash.circle.fill").font(.title)
                                    .foregroundColor(Color(hex: Constants.LightGrayHex))
                                    .padding()
                                    .frame(maxWidth: 45, maxHeight: 45)
                                    .background(Color.red)
                                    .cornerRadius(50)
                                    .padding(.leading)
                                    .padding(.vertical)
                            }
                           
                        }
                    Button { withAnimation(.easeInOut) {
                       
                         
                        if currentPage < 4 {
                            if currentPage == 2  {
                                currentPage = 2
                                startLoading = true
                                startTimer()
                                      
                                    
                                 
                            } else {
                                currentPage += 1
                            }
                        }
                        
                    }} label: {
                        Text(currentPage < 2 ? "Next" : currentPage < 3 ? "\(isUpdatingJob ? "Save" : "Submit")" : "Dismiss")
                            .foregroundColor(.white)
                            .bold()
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hex: Constants.DarkBlueHex))
                            .cornerRadius(10)
                            .padding(.trailing)
                            .padding(.leading, isUpdatingJob ? 5 : 15)
                            .padding(.vertical)
                    }
                    }
                }
            }
            .frame(maxWidth: screenBounds.width - 65, maxHeight: 560, alignment: .center)
            .onReceive(timer) { _ in
                if startLoading && loadingState < 101 {
                    loadingState += loadingIncrement
                } else if loadingState > 99 {
                    currentPage += 1
                    stopTimer()
                }
            }
            .sheet(isPresented: $showPhotoPicker) {
                MediaPicker(filter: .images, limit: 6) { results in
                    MediaPicker.convertToUIImageArray(fromResults: results) { imagesOrNil, errorOrNil in
                        if let error = errorOrNil {
                            print(error)
                        }
                        DispatchQueue.main.async {
                            selectedImages = imagesOrNil ?? []
                            print("[Selected] : \(selectedImages)")

                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
            }
            Spacer()
        }
    }
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
   
}



struct ReelCardView_Previews: PreviewProvider {
    static var previews: some View {
        ReelCardView()
    }
}
