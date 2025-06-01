//
//  PrimaryButton.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppConstants.primaryOrange)
                .cornerRadius(10)
        }
        .padding(.horizontal, AppConstants.horizontalPadding)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Send OTP") {
            print("Button tapped!")
        }
        .background(AppConstants.darkBackground)
        .previewLayout(.sizeThatFits)
    }
}
