//
//  HomeScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    @State private var selectedTab: Tab = .explore

    enum Tab: Hashable {
        case events, explore, chats, profile
    }

    init() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(AppConstants.darkBackground).withAlphaComponent(0.97)

        let unselectedColor = UIColor(AppConstants.secondaryText)
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = unselectedColor
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: unselectedColor]

        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        UITabBar.appearance().isTranslucent = false
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            EventsScreen()
                .tabItem {
                    Label("Events", systemImage: "calendar")
                }
                .tag(Tab.events)

            ExploreScreen()
                .tabItem {
                    Label("Explore", systemImage: "safari.fill")
                }
                .tag(Tab.explore)

            ChatsScreen()
                .tabItem {
                    Label("Chats", systemImage: "message")
                }
                .tag(Tab.chats)

            // ProfileTabScreen now manages its own presentationMode via @Environment
            ProfileTabScreen()
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
                .tag(Tab.profile)
        }
        .accentColor(AppConstants.primaryOrange)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeScreen()
        }
        .environmentObject(KeyboardResponder())
    }
}
