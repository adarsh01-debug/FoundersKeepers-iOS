//
//  HomeScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import Foundation
import SwiftUI

struct HomeScreen: View {
    // Access the presentationMode environment value to dismiss the current view
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all)
            VStack {
                Text("Welcome to the Home Screen!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.bottom, 10) // Add padding for spacing

                Text("You've successfully logged in.")
                    .font(.body)
                    .foregroundColor(AppConstants.secondaryText)
                    .padding(.bottom, 40) // Add more padding before the button

                // Logout Button
                Button(action: {
                    // --- Perform your logout actions here ---
                    // For example:
                    // - Clear user authentication tokens
                    // - Reset any user-specific data
                    // - Update your app's authentication state
                    print("Logout button tapped!")

                    // Dismiss the current view (HomeScreen) to go back to LoginScreen
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Logout")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity) // Make the button fill horizontal space
                        .padding() // Add internal padding
                        .background(AppConstants.primaryOrange) // Use your app's primary orange color
                        .cornerRadius(10) // Rounded corners for the button
                }
                // Apply horizontal padding to the button
                .padding(.horizontal, AppConstants.horizontalPadding)
            }
        }
        .navigationTitle("Home") // Set navigation title (though it's hidden)
        .navigationBarHidden(true) // Keep navigation bar hidden for a cleaner look
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
