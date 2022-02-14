//
//  EmployerSection.swift
//  PeaceWork-iosApp
//
//  Created by Mwai Banda on 1/6/22.
//  Copyright © 2022 orgName. All rights reserved.
//

import SwiftUI
import PeaceWorkSDK 

struct JobCardView: View {
    var job: Job?
    @Binding var postedJobs: [Job]
    @ObservedObject var portfolioViewModel: PortfolioViewModel
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
    @State private var jobTitle = String()
    @State private var compensation = String()
    @State private var compensationSlider = Int()
    @State private var selectedLocationOption: Location = .SingleLocation
    @State private var selectedRangeOption: PayRange = .payPerMonth
    /* Section 2 State */
    @State private var jobDescription = "\u{2022} "
    @State private var selectedEmploymentTypeOption: EmploymentType = .Contract
    @State private var selectedJobTypeOption: JobType = .FullTime
    /* Section 3 State */
    @State private var estimatedStartDate = String()
    @State private var qualifications = "\u{2022} "
    @State private var responsibilities = "\u{2022} "
    
    
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
                        Text(currentPage < 3 ? "Let's Get Started" : "Job \(isUpdatingJob ? "Updated" : "Posted")")
                            .bold()
                            .font(.title2)
                        .foregroundColor(.gray)
                        Text(currentPage < 3 ?  "With \(isUpdatingJob ? "editing" : "this new") posting" : "Congratulations!")
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

                    if currentPage < 1 || currentPage > 1 {
                        if currentPage == 2 && startLoading {
                            ProgressView(value: loadingState, total: 101)
                                .progressViewStyle(LinearProgressViewStyle())
                                .accentColor(Color(hex: Constants.DarkBlueHex))
                                
                        } else {
                            Divider()
                        }
                    }
                    TabView (selection: $currentPage) {
                        JobQuestionSection(jobTitle: $jobTitle, compensation: $compensation, compensationSlider: $compensationSlider, selectedLocationOption: $selectedLocationOption, selectedRangeOption: $selectedRangeOption)
                            .tag(0)
                        JobQuestionSection2(description: $jobDescription, selectedEmploymentTypeOption: $selectedEmploymentTypeOption, selectedJobTypeOption: $selectedJobTypeOption)
                            .tag(1)
                            .offset(y: -20)
                        JobQuestionSection3(qualifications: $qualifications, responsibilities: $responsibilities, estimatedStartDate: $estimatedStartDate)
                            .tag(2)
                        JobQuestionSection4(isSuccessful: $isSuccessful, isUpdatingJob: $isUpdatingJob)
                            .tag(3)
                    }.tabViewStyle(.page(indexDisplayMode: .never))
                    
                    Divider()
                    HStack {
                        if isUpdatingJob {
                            Button {
                                isConfirmedToDelete = true
                                startLoading = true
                                currentPage = 2
                                startTimer()
                                
                                portfolioViewModel.deleteJob(id: job?.id ?? "") { _, err in
                                    if err != nil {
                                        print(err?.localizedDescription ?? "")
                                    } else {
                                        isSuccessful = true
                                        portfolioViewModel.clearUserJobs(id: session.currentUser?.userID ?? "")
                                        portfolioViewModel.getJobsById(id: session.currentUser?.userID ?? "") { jobs, err in
                                            if jobs != nil {
                                                DispatchQueue.main.async {
                                                    postedJobs = jobs ?? []
                                                }
                                            }
                                        }
                                    }
                                }
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
                                DispatchQueue.main.async {
                                      
                                    
                                    if isUpdatingJob {
                                        portfolioViewModel.updateJob(
                                            id: job?.id ?? "",
                                            title: jobTitle,
                                            company: session.company,
                                            location: selectedLocationOption.rawValue,
                                            pay: "\(compensation)",
                                            payRate: selectedRangeOption.identifier,
                                            type: selectedJobTypeOption.identifier,
                                            employmentType: selectedEmploymentTypeOption.identifier,
                                            description: jobDescription,
                                            qualifications: qualifications,
                                            responsibilities: responsibilities,
                                            startDate: estimatedStartDate,
                                            publisher: session.currentUser?.userID ?? "",
                                            contactEmail: session.email
                                        ) { _, err in
                                            if err != nil {
                                                print(err?.localizedDescription ?? "")
                                            } else {
                                                DispatchQueue.main.async {
                                                    isSuccessful = true
                                                    portfolioViewModel.clearUserJobs(id: session.currentUser?.userID ?? "")
                                                    portfolioViewModel.getJobsById(id: session.currentUser?.userID ?? "") { jobs, err in
                                                        if jobs != nil {
                                                            DispatchQueue.main.async {
                                                                postedJobs = jobs ?? []
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        portfolioViewModel.postJob(
                                            title: jobTitle,
                                            company: session.company,
                                            location: selectedLocationOption.rawValue,
                                            pay: "\(compensation)",
                                            payRate: selectedRangeOption.identifier,
                                            type: selectedJobTypeOption.identifier,
                                            employmentType: selectedEmploymentTypeOption.identifier,
                                            description: jobDescription,
                                            qualifications: qualifications,
                                            responsibilities: responsibilities,
                                            startDate: estimatedStartDate,
                                            publisher: session.currentUser?.userID ?? "",
                                            contactEmail: session.email
                                        ) { _, err in
                                            if err != nil {
                                                print(err?.localizedDescription ?? "")
                                            } else {
                                                isSuccessful = true
                                            }
                                        }
                                    }
                                    
                                }
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
            .onAppear {
                if job != nil {
                    guard let unwrappedJob = job else { return }
                    isUpdatingJob = true
                    jobTitle = unwrappedJob.title
                    compensation = unwrappedJob.pay
                    selectedLocationOption = portfolioViewModel.getLocation(
                        location: unwrappedJob.location
                    )
                    selectedRangeOption = portfolioViewModel.getPayRange(
                        payRange: unwrappedJob.payRate
                    )
                    jobDescription = unwrappedJob.description_
                    selectedEmploymentTypeOption = portfolioViewModel.getEmploymentType(
                        employmentType: unwrappedJob.employmentType
                    )
                    selectedJobTypeOption = portfolioViewModel.getJobType(
                        jobType: unwrappedJob.type
                    )
                    estimatedStartDate = unwrappedJob.startDate
                    responsibilities = unwrappedJob.responsibilities
                    qualifications = unwrappedJob.qualifications
                }
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


