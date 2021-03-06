//
//  NavBar.swift
//  Odemmer
//
//  Created by Mwai Banda on 12/16/20.
//  Reusable Navigation Bar

import SwiftUI

enum NavConfig {
    case defaultConfig
    case detailConfig
}
struct NavBar: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var showMenu: Bool
    @Environment(\.presentationMode) var presentationMode
    var navTitle: String?
    var navConfig: NavConfig
    var hasCover: Bool
    var Title: String {
        return navTitle ?? ""
    }
    var body: some View {
        ZStack {
            if navConfig == .defaultConfig {
                ZStack {
                    Color(hex: hasCover ?Constants.DarkBlueHex : Constants.OffWhiteHex ).ignoresSafeArea(.all)

                HStack(alignment:.center){
                   
                    HStack(alignment: .center)  {
                        Button(action: { withAnimation(Animation.easeInOut(duration: 0.5)) {
                            self.showMenu.toggle()
                            presentationMode.wrappedValue.dismiss()
                            let haptic = UIImpactFeedbackGenerator(style: .light)
                            haptic.impactOccurred()
                        }}) {
                            if Title.isEmpty {
                                
                            Image(systemName: showMenu ? "xmark" : "line.horizontal.3").imageScale(.large)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(hasCover ? Color(hex:Constants.OffWhiteHex) : Color.gray)
                                .frame(width: 50, height: 50)
                                .unredacted()
                            }

                        }
                        Spacer()
                        Image(hasCover ? "logo3" : "logo1")
                               .resizable()
                               .aspectRatio( contentMode: .fit)
                            .offset(y: 5)

                    Text((Title.isEmpty ? "" : navTitle) ?? "")
                        .fontWeight(.heavy)
                        .font(.title2)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.white)
                        Spacer()
                        if Title.isEmpty {
                        Button(action: { withAnimation(Animation.easeInOut(duration: 0.5)) {
                             presentationMode.wrappedValue.dismiss()
                            let haptic = UIImpactFeedbackGenerator(style: .light)
                            haptic.impactOccurred()
                        }}) {
                            Image(systemName: "bell").imageScale(.large)
                                .font(.system(size: 20, weight: .medium))
                                .foregroundColor(hasCover ? Color(hex:Constants.OffWhiteHex)  : Color.gray)
                                .frame(width: 50, height: 50)
                        }
                        .offset(x: 10)
                        }
                        
                    }
                  

                }
                .padding(.horizontal)
                }
                .frame(minHeight: 50, maxHeight: 50)
            }
            if navConfig == .detailConfig {
                ZStack {
                    Color.black.ignoresSafeArea(.all)

                HStack(alignment:.center){
                    Button(action: { withAnimation(Animation.easeInOut(duration: 0.5)) {
                        self.showMenu.toggle()
                        presentationMode.wrappedValue.dismiss()
                        let haptic = UIImpactFeedbackGenerator(style: .light)
                        haptic.impactOccurred()
                    }}) {
                        if Title.isEmpty {
                            
                        Image(systemName: showMenu ? "xmark" : "line.horizontal.3").imageScale(.large)
                            .font(.system(size: 25, weight: .medium))
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.white)
                            .frame(width: 50, height: 50)
                            .unredacted()
                        }

                    }
                    HStack(alignment: .firstTextBaseline)  {
                        
                    Text((Title.isEmpty ? "WPRK" : navTitle) ?? "")
                        .fontWeight(.heavy)
                        .font(.title2)
                        .foregroundColor(colorScheme == .dark ? Color.white : Color.white)
                        Spacer()
                        if !Title.isEmpty {
                        Button(action: { withAnimation(Animation.easeInOut(duration: 0.5)) {
                             presentationMode.wrappedValue.dismiss()
                            let haptic = UIImpactFeedbackGenerator(style: .light)
                            haptic.impactOccurred()
                        }}) {
                            Image(systemName: "xmark.circle.fill").imageScale(.large)
                                .font(.system(size: 25, weight: .medium))
                                .foregroundColor(Color.white)
                                .frame(width: 50, height: 50)
                        }
                        .offset(x: 10)
                        }

                    }
                    Spacer(minLength: 0)
                  
                   
                }
                .padding(.horizontal)
                }
                .frame(minHeight: 50,  maxHeight: 50)
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(showMenu: .constant(false), navConfig: .defaultConfig, hasCover: true)
    }
}

