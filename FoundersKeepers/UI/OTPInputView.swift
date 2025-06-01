//
//  OTPInputView.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import Foundation
import SwiftUI

// Enum to manage focus state for each OTP digit
enum OTPField: Hashable {
    case digit1, digit2, digit3, digit4
}

struct OTPInputView: View {
    @Binding var otpCode: String // Binds to the complete OTP string (e.g., "1234")
    @FocusState private var focusedField: OTPField? // Manages focus between fields
    let onOTPCompleted: (String) -> Void // Callback when OTP is fully entered
    let onDismiss: () -> Void // Callback to dismiss the OTP view

    // Internal state for each digit
    @State private var digit1: String = ""
    @State private var digit2: String = ""
    @State private var digit3: String = ""
    @State private var digit4: String = ""

    // Computed property to combine digits into the full OTP
    private var enteredOTP: String {
        "\(digit1)\(digit2)\(digit3)\(digit4)"
    }

    // Initialize individual digits from the binding OTP
    private func setupDigits() {
        if otpCode.count >= 1 { digit1 = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 0)]) }
        if otpCode.count >= 2 { digit2 = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 1)]) }
        if otpCode.count >= 3 { digit3 = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 2)]) }
        if otpCode.count >= 4 { digit4 = String(otpCode[otpCode.index(otpCode.startIndex, offsetBy: 3)]) }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter OTP")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)

            HStack(spacing: 15) {
                // Digit 1
                OTPTextField(digit: $digit1, focusedField: $focusedField, currentField: .digit1, nextField: .digit2)
                // Digit 2
                OTPTextField(digit: $digit2, focusedField: $focusedField, currentField: .digit2, nextField: .digit3, previousField: .digit1)
                // Digit 3
                OTPTextField(digit: $digit3, focusedField: $focusedField, currentField: .digit3, nextField: .digit4, previousField: .digit2)
                // Digit 4
                OTPTextField(digit: $digit4, focusedField: $focusedField, currentField: .digit4, previousField: .digit3)
            }
            .padding(.horizontal)
            .onChange(of: digit1) { _ in updateOTP() }
            .onChange(of: digit2) { _ in updateOTP() }
            .onChange(of: digit3) { _ in updateOTP() }
            .onChange(of: digit4) { _ in updateOTP() }
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(AppConstants.darkBackground) // Dark background for the OTP view
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .onAppear {
            setupDigits() // Initialize digits from bound otpCode
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                focusedField = .digit1 // Auto-focus on the first digit
            }
        }
        .transition(.move(edge: .bottom).combined(with: .opacity)) // Smooth transition
    }

    private func updateOTP() {
        let newOTP = enteredOTP
        self.otpCode = newOTP // Update the binding

        if newOTP.count == 4 {
            hideKeyboard()
            onOTPCompleted(newOTP)
        }
    }
}

// MARK: - Individual OTP Digit TextField
struct OTPTextField: View {
    @Binding var digit: String
    @FocusState.Binding var focusedField: OTPField?
    let currentField: OTPField
    var nextField: OTPField? = nil
    var previousField: OTPField? = nil

    var body: some View {
        TextField("", text: $digit)
            .font(.title2)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .frame(width: 50, height: 50)
            .background(Color.white.opacity(0.1))
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(focusedField == currentField ? AppConstants.primaryOrange : AppConstants.secondaryText.opacity(0.3), lineWidth: 2)
            )
            .focused($focusedField, equals: currentField)
            .onChange(of: digit) { newValue in
                // Ensure only one digit is allowed
                if newValue.count > 1 {
                    digit = String(newValue.prefix(1))
                    // If a digit was entered (e.g., by pasting), immediately move focus
                    if let nextField = nextField {
                        focusedField = nextField
                    } else {
                        hideKeyboard()
                    }
                } else if newValue.count == 1 {
                    // A digit was entered, move to the next field
                    if let nextField = nextField {
                        focusedField = nextField
                    } else {
                        // If it's the last field, hide keyboard
                        hideKeyboard()
                    }
                } else if newValue.isEmpty {
                    // A digit was deleted (backspace), move to the previous field
                    if let previousField = previousField {
                        focusedField = previousField
                    }
                }
            }
    }
}

struct OTPInputView_Previews: PreviewProvider {
    @State static var testOTP: String = ""
    static var previews: some View {
        OTPInputView(otpCode: $testOTP, onOTPCompleted: { otp in print(otp) }, onDismiss: { print("Dismissed") })
            .background(AppConstants.darkBackground)
            .previewLayout(.sizeThatFits)
    }
}
