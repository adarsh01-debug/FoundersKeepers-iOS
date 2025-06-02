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
        // MARK: - TabBar Appearance Configuration for a SOLID background
        let tabBarAppearance = UITabBarAppearance()
        
        // 1. Configure for an OPAQUE background (replaces configureWithTransparentBackground)
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(AppConstants.darkBackground)
        
        // 3. Configure colors for tab items (unselected state)
        let unselectedTabColor = UIColor(AppConstants.secondaryText)
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = unselectedTabColor
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: unselectedTabColor]
        
        // 4. Apply this appearance to the standard and scroll edge states
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().isTranslucent = false
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(AppConstants.darkBackground)
        let titleColor = UIColor.white
        navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
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
