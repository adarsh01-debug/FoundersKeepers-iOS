//
//  ExploreScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

// Define a struct for User Profile data
struct UserProfile: Identifiable, Equatable {
    let id = UUID()
    var userImageName: String?
    var name: String
    var distance: String
    var interests: [String]
    var bio: String

    // Sample Data (Add more profiles as needed)
    static let sampleProfiles: [UserProfile] = [
        UserProfile(userImageName: nil, name: "Steve Jobs", distance: "3 kms away", interests: ["Co-founder", "Product", "Thinker"], bio: "Visionary innovator with a passion for design and user experience. Seeking a co-founder who can help me disrupt industries and build something truly groundbreaking. If you’re obsessed with simplicity, elegance, and pushing the boundaries of technology, let’s create the next big thing together."),
        UserProfile(userImageName: "sample_avatar_2", name: "Ada Lovelace", distance: "5 kms away", interests: ["Visionary", "Programming", "Analytics"], bio: "Pioneer of programming and analytics, often called the 'Enchantress of Numbers.' Looking for a collaborator to explore the frontiers of technology and build innovative solutions. If you’re passionate about algorithms, data, and creating the future of computing, join me in crafting the next chapter of innovation."),
        UserProfile(userImageName: nil, name: "Nikola Tesla", distance: "10 kms away", interests: ["Inventor", "Futurist", "AC Current"], bio: "Inventor and futurist with a focus on electricity, energy, and wireless technology. Seeking a partner to help bring my bold ideas to life, especially in sustainable energy and wireless communication. If you’re driven by curiosity and ready to challenge the impossible, let’s power the future together."),
        UserProfile(userImageName: "sample_avatar_3", name: "Marie Curie", distance: "2 kms away", interests: ["Science", "Research", "Physics"], bio: "Groundbreaking scientist dedicated to research and discovery in physics and chemistry. Looking for a collaborator who shares my passion for pushing the boundaries of science. If you’re committed to rigorous experimentation and eager to explore the unknown, join me in uncovering the next scientific breakthrough.")
    ]
}

// Enum to represent swipe direction
enum SwipeDirection {
    case left, right, none
}

struct ExploreScreen: View {
    @State private var profiles: [UserProfile] = UserProfile.sampleProfiles
    @State private var currentProfileIndex: Int = 0
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showNoMoreProfiles = false

    // Threshold for a swipe to be considered complete
    let swipeThreshold: CGFloat = 100 // Adjust as needed

    var body: some View {
        ZStack {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all)

            if showNoMoreProfiles {
                VStack {
                    Text("No More Profiles")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Check back later for new connections!")
                        .font(.headline)
                        .foregroundColor(AppConstants.secondaryText)
                        .padding(.top, 8)
                    Button("Reload Profiles") {
                        profiles = UserProfile.sampleProfiles // Or fetch new ones
                        currentProfileIndex = 0
                        showNoMoreProfiles = false
                    }
                    .padding(.top, 20)
                    .buttonStyle(PrimaryButtonStyle()) // Assuming you might want a styled button
                }
            } else if currentProfileIndex < profiles.count {
                // Stack of Profile Cards
                ZStack {
                    // Background cards (show a couple for stacking effect)
                    ForEach(Array(profiles.enumerated().reversed()), id: \.element.id) { index, profile in
                        if index > currentProfileIndex && index < currentProfileIndex + 3 { // Show next 2 cards
                             ProfileCardView(profile: profile, isTopCard: false)
                                .zIndex(Double(profiles.count - 1 - index)) // Ensure correct stacking order
                                .offset(y: CGFloat(index - currentProfileIndex) * 10) // Slight offset for stacking
                                .scaleEffect(1.0 - (CGFloat(index - currentProfileIndex) * 0.05)) // Slightly smaller
                                .padding(.horizontal, AppConstants.horizontalPadding / 2)
                        }
                    }

                    // Top, Draggable Card
                    if currentProfileIndex < profiles.count { // Add this check for safety
                        ProfileCardView(profile: profiles[currentProfileIndex], isTopCard: true, onSwipe: handleSwipe)
                            .id(profiles[currentProfileIndex].id) // <<-- CRUCIAL ADDITION HERE
                            .zIndex(Double(profiles.count))
                            .padding(.horizontal, AppConstants.horizontalPadding / 2)
                    }
                }
                .padding(.top, AppConstants.largeVerticalSpacing)
            }

            // Action buttons (optional, can also rely purely on swipe)
            if !showNoMoreProfiles && currentProfileIndex < profiles.count {
                VStack {
                    Spacer()
                    HStack(spacing: AppConstants.largeVerticalSpacing) {
                        CircularButton(iconName: "xmark", color: AppConstants.secondaryText.opacity(0.8)) {
                            // Trigger reject programmatically
                            if currentProfileIndex < profiles.count {
                                handleSwipe(profile: profiles[currentProfileIndex], direction: .left)
                            }
                        }
                        CircularButton(iconName: "hand.thumbsup.fill", color: AppConstants.primaryOrange) {
                            // Trigger accept programmatically
                            if currentProfileIndex < profiles.count {
                                handleSwipe(profile: profiles[currentProfileIndex], direction: .right)
                            }
                        }
                    }
                    .padding(.bottom, AppConstants.largeVerticalSpacing * 1.5)
                }
            }
        }
        .scrollIndicators(.hidden) // Hides scroll indicators if ScrollView was still present
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Connection Request"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func handleSwipe(profile: UserProfile, direction: SwipeDirection) {
        guard let swipedProfileIndex = profiles.firstIndex(where: { $0.id == profile.id }), swipedProfileIndex == currentProfileIndex else {
            // This swipe is not for the current top card, or card already swiped by other means
            return
        }
        
        withAnimation(.spring()) {
            currentProfileIndex += 1
            if currentProfileIndex >= profiles.count {
                showNoMoreProfiles = true
            }
        }

        switch direction {
        case .left:
            print("Rejected: \(profile.name)")
            // Add backend call or local logic for rejection
        case .right:
            print("Accepted: \(profile.name)")
            alertMessage = "You've shown interest in \(profile.name)! They will be notified and may contact you soon."
            showAlert = true
            // Add backend call or local logic for acceptance
        case .none:
            // Should not happen if swipe is triggered from card completion
            break
        }
    }
}

// Reusable Circular Button for actions
struct CircularButton: View {
    let iconName: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(.system(size: iconName == "xmark" ? 24 : 28, weight: .bold))
                .foregroundColor(color)
                .padding(iconName == "xmark" ? 18 : 22) // Slightly different padding for visual balance
                .background(Color.white.opacity(0.12))
                .clipShape(Circle())
                .shadow(color: color.opacity(0.4), radius: 5, y: 3)
        }
    }
}

// Reusable Primary Button Style (if you don't have one globally)
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(AppConstants.primaryOrange)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.97 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}


struct ProfileCardView: View {
    let profile: UserProfile
    var isTopCard: Bool // To enable gestures only for the top card
    var onSwipe: ((UserProfile, SwipeDirection) -> Void)? = nil // Callback for swipe action

    // State for gesture handling
    @State private var offset: CGSize = .zero
    @State private var rotation: Angle = .degrees(0)
    @State private var feedbackText: String? = nil
    @State private var feedbackColor: Color = .clear

    // Constants for swipe mechanics
    private let swipeThreshold: CGFloat = 100 // How far to drag for a swipe
    private let rotationMultiplier: Double = (45 / (UIScreen.main.bounds.width / 2)) // Max rotation degrees
    private let offscreenDistance: CGFloat = UIScreen.main.bounds.width * 1.5 // How far card flies off

    var body: some View {
        let dragGesture = DragGesture()
            .onChanged { value in
                guard isTopCard else { return } // Only top card is draggable
                offset = value.translation
                let rotationAngle = Double(value.translation.width / (UIScreen.main.bounds.width / 2)) * rotationMultiplier
                rotation = .degrees(rotationAngle)
                
                // Update feedback text based on swipe direction
                if value.translation.width > 20 {
                    feedbackText = "LIKE"
                    feedbackColor = Color.green.opacity(0.7)
                } else if value.translation.width < -20 {
                    feedbackText = "NOPE"
                    feedbackColor = Color.red.opacity(0.7)
                } else {
                    feedbackText = nil
                }
            }
            .onEnded { value in
                guard isTopCard else { return }
                let swipeDirection: SwipeDirection
                var targetOffset = CGSize.zero
                var targetRotation = Angle.zero

                if abs(value.translation.width) > swipeThreshold { // Swipe completed
                    if value.translation.width > 0 { // Right swipe (Accept)
                        swipeDirection = .right
                        targetOffset = CGSize(width: offscreenDistance, height: 0)
                        targetRotation = .degrees(rotationMultiplier * 2)
                    } else { // Left swipe (Reject)
                        swipeDirection = .left
                        targetOffset = CGSize(width: -offscreenDistance, height: 0)
                        targetRotation = .degrees(-rotationMultiplier * 2)
                    }
                    
                    // Perform swipe action with animation
                    withAnimation(.interpolatingSpring(mass: 1.0, stiffness: 50, damping: 10, initialVelocity: 0)) {
                        offset = targetOffset
                        rotation = targetRotation
                    }
                    
                    // Use a slight delay to allow animation to start before removing card / calling callback
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                         onSwipe?(profile, swipeDirection)
                    }

                } else { // Swipe not completed, return to center
                    swipeDirection = .none
                    withAnimation(.spring()) {
                        offset = .zero
                        rotation = .zero
                    }
                }
                feedbackText = nil // Clear feedback text
            }

        VStack(spacing: AppConstants.verticalSpacing - 5) {
            // User Image
            Group {
                if let imageName = profile.userImageName, let uiImage = UIImage(named: imageName) {
                    Image(uiImage: uiImage)
                        .resizable()
                } else {
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .foregroundColor(AppConstants.secondaryText)
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 120, height: 120)
            .clipShape(Circle())
            .padding(.top, AppConstants.verticalSpacing)
            .shadow(color: AppConstants.primaryOrange.opacity(0.3), radius: 5, y: 3)

            Text(profile.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text(profile.distance)
                .font(.callout)
                .foregroundColor(AppConstants.secondaryText.opacity(0.8))

            HStack(spacing: 8) {
                ForEach(profile.interests.prefix(3), id: \.self) { interest in
                    Text(interest)
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .foregroundColor(AppConstants.primaryOrange)
                        .background(AppConstants.primaryOrange.opacity(0.15))
                        .clipShape(Capsule())
                }
            }
            .padding(.vertical, AppConstants.verticalSpacing / 2)

            Text(profile.bio)
                .font(.footnote)
                .foregroundColor(AppConstants.secondaryText)
                .multilineTextAlignment(.center)
                .padding(.horizontal, AppConstants.horizontalPadding)
                .fixedSize(horizontal: false, vertical: true)

            Spacer() // Pushes action buttons towards the bottom
        }
        .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.80) // Adjusted size
        .background(
            LinearGradient(
                // Using a default dark gradient. Replace with AppConstants.exploreCardViewBgColor if defined.
                gradient: Gradient(colors: [AppConstants.exploreCardViewBgColor]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .stroke(AppConstants.primaryOrange.opacity(offset == .zero ? 0.1 : 0.0), lineWidth: 2) // Subtle border [cite: adarsh01-debug/founderskeepers-ios/adarsh01-debug-FoundersKeepers-iOS-d873c7b543dad6ba76f6be01cf9d08ad00dda9ea/FoundersKeepers/Constants/AppConstants.swift]
        )
        .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 4)
        .overlay( // Swipe Feedback Overlay
            ZStack {
                if let text = feedbackText {
                    Text(text)
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(feedbackColor)
                        .padding(10)
                        .background(feedbackColor.opacity(0.1))
                        .cornerRadius(10)
                        .rotationEffect(.degrees(-15)) // Tilt the feedback text
                        .opacity(abs(offset.width) / (swipeThreshold / 2)) // Fade in/out
                }
            }
        )
        .offset(x: offset.width, y: offset.height * 0.4) // Allow some vertical movement with swipe
        .rotationEffect(rotation)
        .gesture(isTopCard ? dragGesture : nil) // Only apply gesture to the top card
        .animation(.interactiveSpring(), value: offset) // Make drag feel more natural
        .animation(.interactiveSpring(), value: rotation)
    }
}

struct ExploreScreen_Previews: PreviewProvider {
    static var previews: some View {
        ExploreScreen()
            .preferredColorScheme(.dark)
    }
}
