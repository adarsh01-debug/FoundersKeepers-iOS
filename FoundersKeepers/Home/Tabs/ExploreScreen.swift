//
//  ExploreScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct ExploreScreen: View {
    var body: some View {
        ZStack {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all) //
            
            // The main content of the Explore tab, likely a scrollable or swipeable view of profiles.
            // For this example, a single ProfileCardView is shown.
            ScrollView { // Added ScrollView for potential multiple cards or taller content
                VStack {
                    Spacer(minLength: AppConstants.largeVerticalSpacing) //
                    ProfileCardView(
                        // Placeholder data based on the provided image and typical profile info.
                        userImageName: nil, // Using nil to show default placeholder, or provide an asset name string.
                        name: "Steve Jobs",
                        distance: "3 kms away",
                        interests: ["Co-founder", "Product", "Thinker"],
                        bio: "Looking for a co-founder to build something groundbreaking." // Placeholder bio
                    )
                    Spacer(minLength: AppConstants.largeVerticalSpacing) //
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

struct ProfileCardView: View {
    let userImageName: String? // Name of image asset, if available
    let name: String
    let distance: String
    let interests: [String]
    let bio: String

    var body: some View {
        VStack(spacing: AppConstants.verticalSpacing - 5) { // Reduced spacing slightly for compactness
            // User Image
            Group {
                if let imageName = userImageName, let uiImage = UIImage(named: imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                } else {
                    // Default placeholder if image name is nil or image not found
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(AppConstants.secondaryText) //
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .padding(.top, AppConstants.verticalSpacing) //
            .shadow(color: AppConstants.primaryOrange.opacity(0.3), radius: 5, y: 3) //


            // Name and Age
            Text("\(name)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            // Distance
            Text(distance)
                .font(.callout)
                .foregroundColor(AppConstants.secondaryText.opacity(0.8)) //

            // Interests - Pill Views
            HStack(spacing: 8) {
                ForEach(interests.prefix(3), id: \.self) { interest in // Show up to 3 interests
                    Text(interest)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundColor(AppConstants.primaryOrange) //
                        .background(AppConstants.primaryOrange.opacity(0.15)) //
                        .clipShape(Capsule())
                }
            }
            .padding(.vertical, AppConstants.verticalSpacing / 2) //

            // Bio
            Text(bio)
                .font(.footnote)
                .foregroundColor(AppConstants.secondaryText) //
                .multilineTextAlignment(.center)
                .lineLimit(3) // Allow up to 3 lines for bio
                .padding(.horizontal, AppConstants.horizontalPadding) //
                .fixedSize(horizontal: false, vertical: true) // Allows text to wrap and define height

            Spacer() // Pushes action buttons towards the bottom of the card content area

            // Action Buttons (Cross and Heart)
            HStack(spacing: AppConstants.largeVerticalSpacing) { //
                Button(action: {
                    print("Dismiss tapped for \(name)")
                    // Handle dismiss action
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(AppConstants.secondaryText.opacity(0.7)) //
                        .padding(15)
                        .background(Color.white.opacity(0.08))
                        .clipShape(Circle())
                        .shadow(radius: 3)
                }

                Button(action: {
                    print("Like tapped for \(name)")
                    // Handle like action
                }) {
                    Image(systemName: "heart.fill")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(AppConstants.primaryOrange) //
                        .padding(20)
                        .background(Color.white.opacity(0.08))
                        .clipShape(Circle())
                        .shadow(color: AppConstants.primaryOrange.opacity(0.5), radius: 5, y: 3) //
                }
            }
            .padding(.bottom, AppConstants.largeVerticalSpacing) //
        }
        .frame(width: UIScreen.main.bounds.width * 0.9) // Card takes 90% of screen width
        .frame(minHeight: UIScreen.main.bounds.height * 0.80) // Minimum height
        .background(
            LinearGradient(
                gradient: Gradient(colors: [AppConstants.exploreCardViewBgColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(AppConstants.primaryOrange_alpha05.opacity(0.3), lineWidth: 1) //
        )
        .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 4)
    }
}

struct ExploreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExploreScreen()
            .preferredColorScheme(.dark) // Ensure preview is in dark mode if relevant
    }
}
