//
//  ProfileTabScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

// This is the main view for the Profile Tab
struct ProfileTabScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all)
            VStack(spacing: AppConstants.verticalSpacing) {
                Text("My Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, AppConstants.largeVerticalSpacing)

                Text("Manage your account details and preferences.")
                    .font(.headline)
                    .foregroundColor(AppConstants.secondaryText)
                    .padding(.bottom, AppConstants.verticalSpacing)

                // Usage of ProfileRow
                VStack(alignment: .leading, spacing: AppConstants.verticalSpacing) {
                    ProfileRow(iconName: "person.fill", text: "Edit Profile")
                    ProfileRow(iconName: "slider.horizontal.3", text: "Preferences")
                    ProfileRow(iconName: "shield.lefthalf.filled", text: "Security")
                    ProfileRow(iconName: "questionmark.circle.fill", text: "Help & Support")
                }
                .padding(.horizontal, AppConstants.horizontalPadding)

                Spacer()

                PrimaryButton(title: "Logout") {
                    print("Logout button tapped from Profile tab!")
                    self.presentationMode.wrappedValue.dismiss()
                }
                .padding(.bottom, AppConstants.largeVerticalSpacing)
            }
            .padding(.horizontal, AppConstants.horizontalPadding)
        }
    }
}

// Definition for ProfileRow - ensure this is in the same file (ProfileTabScreen.swift)
// or in a location accessible to this file.
struct ProfileRow: View {
    let iconName: String
    let text: String

    var body: some View {
        Button(action: {
            print("\(text) tapped")
            // Handle action for this row
        }) {
            HStack {
                Image(systemName: iconName)
                    .foregroundColor(AppConstants.primaryOrange)
                    .frame(width: 25, alignment: .center)
                Text(text)
                    .foregroundColor(.white)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(AppConstants.secondaryText)
            }
            .padding(.vertical, AppConstants.verticalSpacing / 1.5)
            .background(Color.clear)
        }
        Divider().background(AppConstants.secondaryText.opacity(0.3))
    }
}

// Preview for ProfileTabScreen
struct ProfileTabScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileTabScreen()
        }
        .preferredColorScheme(.dark)
    }
}
