//
//  LoginScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import SwiftUI

struct LoginScreen: View {
    @State private var phoneNumber: String = ""
    @State private var showOtpView: Bool = false
    @State private var otpCode: String = ""
    @State private var navigateToHome: Bool = false // For programmatic navigation

    // Removed @ObservedObject private var keyboard = KeyboardResponder()

    var body: some View {
        NavigationView { // Wrap the whole view in NavigationView for navigation
            ZStack {
                AppConstants.darkBackground.edgesIgnoringSafeArea(.all)
                // Removed .ignoresSafeArea(.keyboard, edges: .bottom) as it's less relevant now

                VStack {
                    // Custom Navigation Bar
                    HStack {
                        Text("Login")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            print("Home button tapped!")
                        }) {
                            Text("Home")
                                .font(.body)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, AppConstants.horizontalPadding)
                    .padding(.top) // Add top padding for safe area
                    .padding(.bottom, AppConstants.largeVerticalSpacing) // Space before header

                    // ScrollView for content to handle keyboard or small screens
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: AppConstants.verticalSpacing) {
                            AuthHeaderView()

                            PhoneInputView(phoneNumber: $phoneNumber)

                            PrimaryButton(title: "Send OTP") {
                                self.hideKeyboard() // Dismiss phone keyboard
                                if isValidPhoneNumber(phoneNumber) {
                                    showOtpView = true
                                    otpCode = "" // Ensure OTP is clear for new input
                                    print("Phone number is valid. Showing OTP view.")
                                    // In a real app, you'd send OTP to this number
                                } else {
                                    print("Invalid phone number. Must be 10 digits.")
                                    // Show an alert or error message to the user
                                }
                            }
                            .padding(.top, AppConstants.verticalSpacing) // Space before button

                            TermsAndPrivacyView()

                            Spacer() // Pushes content to the top
                        }
                        .frame(maxWidth: .infinity) // Ensure content takes full width
                    }
                    
                    // NEW: Conditionally show OTPInputView here, above the footer
                    if showOtpView {
                        OTPInputView(
                            otpCode: $otpCode,
                            onOTPCompleted: { receivedOTP in
                                if receivedOTP == "1234" {
                                    print("OTP matched! Navigating to Home Screen.")
                                    navigateToHome = true
                                    showOtpView = false // Dismiss OTP view
                                } else {
                                    print("Incorrect OTP: \(receivedOTP)")
                                    otpCode = "" // Clear for retry
                                }
                            },
                            onDismiss: {
                                // This onDismiss will be triggered by an explicit close button if you add one inside OTPInputView
                                // For now, tapping outside handles dismissal.
                                showOtpView = false
                                otpCode = ""
                                hideKeyboard()
                            }
                        )
                        .padding(.top, AppConstants.verticalSpacing) // Add some space above it
                        .transition(.opacity.animation(.easeOut(duration: 0.3))) // Simple fade transition
                    }

                    // Footer (remains at the bottom of the VStack)
                    Text("© 2025 Founders Keepers App. All rights reserved.")
                        .font(.caption)
                        .foregroundColor(AppConstants.secondaryText)
                        .padding(.bottom) // Padding from the bottom edge
                }

                // NavigationLink to HomeScreen, activated programmatically
                NavigationLink(destination: HomeScreen(), isActive: $navigateToHome) {
                    EmptyView()
                }
                .hidden() // Hide the default NavigationLink UI
            }
            // This onTapGesture will now handle both keyboard dismissal and OTP view dismissal
            .contentShape(Rectangle()) // Make the whole background tappable for keyboard dismiss
            .onTapGesture {
                if showOtpView {
                    showOtpView = false // Dismiss OTP view when tapping outside
                    otpCode = "" // Clear OTP
                }
                self.hideKeyboard() // Always hide keyboard on tap outside
            }
            // Add a semi-transparent dark background when OTP view is shown
            // This is now an overlay on the ZStack, giving a modal look
            .background(
                Group {
                    if showOtpView {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                // This specific tap gesture on the background itself also dismisses the OTP view
                                showOtpView = false
                                otpCode = ""
                                hideKeyboard()
                            }
                    }
                }
            )
            .navigationBarHidden(true) // Hide the default NavigationView bar
        }
    }

    // Phone number validation function
    private func isValidPhoneNumber(_ number: String) -> Bool {
        let digitsOnly = number.filter { $0.isNumber }
        return digitsOnly.count == 10
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
