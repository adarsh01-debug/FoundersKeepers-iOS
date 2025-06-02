//
//  CustomAlertView.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct CustomAlertView: View {
    @Binding var isPresented: Bool
    
    let iconName: String
    let iconColor: Color
    let title: String
    let message: String
    
    let primaryButtonTitle: String
    let primaryButtonAction: () -> Void
    var primaryButtonColor: Color = AppConstants.primaryOrange //
    
    var secondaryButtonTitle: String? = nil
    var secondaryButtonAction: (() -> Void)? = nil
    var secondaryButtonColor: Color = AppConstants.primaryOrange //

    @State private var animate = false

    var body: some View {
        if isPresented {
            ZStack {
                // Dimmed background
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        // Optional: dismiss on tap outside if appropriate for all alerts
                        // isPresented = false
                    }

                VStack(spacing: 0) {
                    Image(systemName: iconName)
                        .font(.system(size: 36, weight: .bold)) // Adjusted size from image
                        .foregroundColor(.white)
                        .padding(20)
                        .background(iconColor)
                        .clipShape(Circle())
                        .padding(.top, AppConstants.largeVerticalSpacing) //
                        .shadow(color: iconColor.opacity(0.5), radius: 8, y: 4)

                    Text(title)
                        .font(.title2.weight(.bold))
                        .foregroundColor(.white)
                        .padding(.top, AppConstants.verticalSpacing) //

                    Text(message)
                        .font(.subheadline)
                        .foregroundColor(AppConstants.secondaryText) //
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, AppConstants.horizontalPadding) //
                        .padding(.top, AppConstants.verticalSpacing / 2) //
                        .padding(.bottom, AppConstants.largeVerticalSpacing) //

                    // Buttons
                    VStack(spacing: AppConstants.verticalSpacing - 5) { //
                        Button(action: {
                            primaryButtonAction()
                            withAnimation { isPresented = false }
                        }) {
                            Text(primaryButtonTitle)
                                .font(.headline.weight(.semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding(AppConstants.verticalSpacing) //
                                .background(primaryButtonColor)
                                .cornerRadius(12)
                        }

                        if let title = secondaryButtonTitle, let action = secondaryButtonAction {
                            Button(action: {
                                action()
                                withAnimation { isPresented = false }
                            }) {
                                Text(title)
                                    .font(.headline.weight(.semibold))
                                    .foregroundColor(secondaryButtonColor) // Use the passed color
                                    .frame(maxWidth: .infinity)
                                    .padding(AppConstants.verticalSpacing) //
                                    .background(Color.clear) // Transparent background for bordered button
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(secondaryButtonColor, lineWidth: 1.5) // Bordered style
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, AppConstants.horizontalPadding) //
                    .padding(.bottom, AppConstants.largeVerticalSpacing) //

                }
                .frame(width: UIScreen.main.bounds.width * 0.8, height: animate ? nil : 0) // Width from image, animate height
                .fixedSize(horizontal: false, vertical: true) // Allow card to grow vertically based on content
                .background(AppConstants.eventProfileSectionBackground) //
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.25), radius: 10, x: 0, y: 4)
                .scaleEffect(animate ? 1 : 0.7)
                .opacity(animate ? 1 : 0)
            }
            .onAppear {
                withAnimation(.spring(response: 0.4, dampingFraction: 0.7, blendDuration: 0)) {
                    animate = true
                }
            }
            .transaction { A in // Ensure the binding is updated correctly for dismissal animation
                if !isPresented { A.animation = .easeOut(duration: 0.3) }
            }
        }
    }
}

// View Modifier for easier presentation
struct CustomAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    let alertContent: CustomAlertView // Pass the fully configured CustomAlertView

    func body(content: Content) -> some View {
        ZStack {
            content // The view this modifier is applied to
            if isPresented {
                alertContent
            }
        }
    }
}

extension View {
    func customAlert(
        isPresented: Binding<Bool>,
        iconName: String = "checkmark.circle.fill",
        iconColor: Color = AppConstants.successGreen,
        title: String,
        message: String,
        primaryButtonTitle: String,
        primaryButtonAction: @escaping () -> Void,
        primaryButtonColor: Color = AppConstants.primaryOrange, //
        secondaryButtonTitle: String? = nil,
        secondaryButtonAction: (() -> Void)? = nil,
        secondaryButtonColor: Color = AppConstants.primaryOrange //
    ) -> some View {
        let alertView = CustomAlertView(
            isPresented: isPresented,
            iconName: iconName,
            iconColor: iconColor,
            title: title,
            message: message,
            primaryButtonTitle: primaryButtonTitle,
            primaryButtonAction: primaryButtonAction,
            primaryButtonColor: primaryButtonColor,
            secondaryButtonTitle: secondaryButtonTitle,
            secondaryButtonAction: secondaryButtonAction,
            secondaryButtonColor: secondaryButtonColor
        )
        return self.modifier(CustomAlertModifier(isPresented: isPresented, alertContent: alertView))
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Preview Content")
        }
        .customAlert(
            isPresented: .constant(true),
            iconName: "checkmark.circle.fill",
            iconColor: .green,
            title: "Congratulations!",
            message: "You have successfully placed order for party with friends. Enjoy the event!",
            primaryButtonTitle: "View E-Ticket",
            primaryButtonAction: { print("View E-Ticket tapped") },
            secondaryButtonTitle: "Go to Home",
            secondaryButtonAction: { print("Go to Home tapped") }
        )
        .preferredColorScheme(.dark)
    }
}
