//
//  Tabbar.swift
//  PeaceWork (iOS)
//
//  Created by Mwai Banda on 12/16/21.
//

import SwiftUI

struct BottomTabBar: View {
    init() {
        
        let itemAppearance = UITabBarItemAppearance()
        itemAppearance.normal.iconColor = UIColor(Color(.lightGray))
        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(Color(.lightGray))]
        let appearance = UITabBarAppearance()
        appearance.shadowColor = UIColor(Color.black)
        appearance.backgroundColor = UIColor(Color(hex: Constants.OffWhiteHex))
        appearance.stackedLayoutAppearance = itemAppearance
        appearance.inlineLayoutAppearance = itemAppearance
        appearance.compactInlineLayoutAppearance = itemAppearance
    
        UITabBar.appearance().standardAppearance = appearance
        
        
    }
    @EnvironmentObject var session: Session
    @StateObject var loungeViewModel =  LoungeViewModel()
    @StateObject var conversationViewModel = ConversationViewModel()
    var body: some View {
        TabView {
            NavigationView {
                ContentWrapper {
                    LoungeView(loungeViewModel: loungeViewModel, conversationViewModel: conversationViewModel)
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tag(0)
            .tabItem {
                Image(systemName: "person.2.wave.2")
                Text("Lounge")
            }
            
            NavigationView {
                ContentWrapper {
                    SearchView()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tag(1)
            .tabItem {
                Image(systemName: "text.magnifyingglass")
                Text("Search")
            }
            
            NavigationView {
                ContentWrapper(hasCover: true) {
                    PortfolioView()
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tag(2)
            .tabItem {
                Image(systemName: "briefcase")
                Text("Portfolio")
            }
            
        }
        .accentColor(Color(hex: Constants.DarkBlueHex))
    }
}

struct BottomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomTabBar()
            .environmentObject(Session())
    }
}
