//
//  PhoneInputView.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import Foundation
import SwiftUI

struct PhoneInputView: View {
    @Binding var phoneNumber: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Phone Number")
                .font(.headline)
                .foregroundColor(.white)

            HStack {
                Image(systemName: "phone.fill")
                    .foregroundColor(AppConstants.primaryOrange)
                TextField("Enter your phone number", text: $phoneNumber)
                    .keyboardType(.phonePad)
                    .foregroundColor(.white)
                    .placeholder(when: phoneNumber.isEmpty) { // Using a custom extension for placeholder color
                        Text("Enter your phone number")
                            .foregroundColor(AppConstants.secondaryText)
                    }
            }
            .padding()
            .background(Color.white.opacity(0.1)) // Slightly transparent background for the text field
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppConstants.secondaryText.opacity(0.3), lineWidth: 1)
            )

            Text("We'll send a verification code to this number")
                .font(.footnote)
                .foregroundColor(AppConstants.secondaryText)
        }
        .padding(.horizontal, AppConstants.horizontalPadding)
    }
}

// Custom TextField Extension to change placeholder color
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct PhoneInputView_Previews: PreviewProvider {
    @State static var phoneNumber: String = ""

    static var previews: some View {
        PhoneInputView(phoneNumber: $phoneNumber)
            .background(AppConstants.darkBackground)
            .previewLayout(.sizeThatFits)
    }
}
