//
//  EventsScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct EventsScreen: View {
    @State private var events: [Event] = Event.sampleEvents

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all)
                
            ScrollView {
                // Layer 2: Main content (Header + Scrollable list)
                VStack(alignment: .leading, spacing: 0) {
                    // Header Section (as previously defined)
                    HStack {
                        Image(systemName: "calendar.badge.plus")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(AppConstants.primaryOrange)
                            .padding(8)
                            .background(AppConstants.primaryOrange.opacity(0.15))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading) {
                            Text("Events Near You")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Discover and join amazing events")
                                .font(.caption)
                                .foregroundColor(AppConstants.secondaryText)
                        }
                    }
                    .padding(.horizontal, AppConstants.horizontalPadding)
                    .padding(.top, AppConstants.largeVerticalSpacing)
                    .padding(.bottom, AppConstants.verticalSpacing)
                    
                    LazyVStack(spacing: AppConstants.verticalSpacing) {
                        ForEach(events) { event in
                            NavigationLink(destination: EventProfileScreen(event: event)) {
                                EventCardView(event: event)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.horizontal, AppConstants.horizontalPadding)
                    // This padding ensures the last item in scroll view isn't hidden by the FAB
                    .padding(.bottom, 80) // Adjust this based on FAB size + desired spacing
                }
                .scrollIndicators(.hidden)
            }
            
            // Layer 3: Floating Action Button (FAB)
            Button(action: {
                print("FAB Tapped! - Implement action e.g., create new event")
            }) {
                AppConstants.primaryOrange
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(color: AppConstants.primaryOrange.opacity(0.5), radius: 8, y: 4)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    )
            }
            // Padding for FAB from the edges of the ZStack.
            // Since ZStack ignores safe area, this padding is from the physical edges.
            .padding() // General padding, adjust as needed e.g., .padding([.bottom, .trailing], 20)
        }
        .background(AppConstants.darkBackground) // Ensure ZStack itself has the dark background
        // This background will now go edge-to-edge due to ignoresSafeArea.
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        // Using .stack navigation view style can prevent some layout issues with TabView on iPad,
        // but it's often the default on iPhone for this kind of setup.
        // .navigationViewStyle(.stack)
    }
}

struct EventsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EventsScreen()
            .preferredColorScheme(.dark)
    }
}
