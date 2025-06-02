//
//  EventsScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct EventsScreen: View {
    // Sample events data, replace with actual data source / view model
    @State private var events: [Event] = Event.sampleEvents

    var body: some View {
        ZStack(alignment: .bottomTrailing) { // ZStack for FAB
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all) //

            VStack(alignment: .leading, spacing: 0) {
                // Header Section
                HStack {
                    Image(systemName: "calendar.badge.plus") // Icon from image
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppConstants.primaryOrange) //
                        .padding(8)
                        .background(AppConstants.primaryOrange.opacity(0.15)) //
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text("Events Near You") // Text from image
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Discover and join amazing events") // Text from image
                            .font(.caption)
                            .foregroundColor(AppConstants.secondaryText) //
                    }
                }
                .padding(.horizontal, AppConstants.horizontalPadding) //
                .padding(.top, AppConstants.largeVerticalSpacing) //
                .padding(.bottom, AppConstants.verticalSpacing) //

                // List of Events
                ScrollView {
                    LazyVStack(spacing: AppConstants.verticalSpacing) { //
                        ForEach(events) { event in
                            EventCardView(event: event)
                        }
                    }
                    .padding(.horizontal, AppConstants.horizontalPadding) //
                    .padding(.bottom, AppConstants.largeVerticalSpacing * 2) // Padding for FAB space
                }
                .scrollIndicators(.hidden)
            }

            // Floating Action Button (FAB)
            Button(action: {
                print("FAB Tapped! - Implement action e.g., create new event")
                // Add action for FAB, e.g., navigate to a create event screen
            }) {
                AppConstants.primaryOrange //
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .shadow(color: AppConstants.primaryOrange.opacity(0.5), radius: 8, y: 4) //
                    .overlay(
                        Image(systemName: "plus") // Example icon for FAB
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                    )
            }
            .padding(AppConstants.horizontalPadding) //
            // Adjust padding if tab bar is opaque and FAB should sit above it more clearly.
            // If your tab bar is translucent, this padding might be enough.
        }
    }
}

struct EventsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EventsScreen()
            .preferredColorScheme(.dark)
    }
}
