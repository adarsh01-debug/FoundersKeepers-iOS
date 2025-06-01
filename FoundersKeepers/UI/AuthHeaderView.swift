//
//  AuthHeaderView.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import Foundation
import SwiftUI

struct AuthHeaderView: View {
    var body: some View {
        VStack(spacing: AppConstants.verticalSpacing) {
            // Phone Icon with Orange Background
            ZStack {
                Circle()
                    .fill(AppConstants.primaryOrange_alpha05)
                    .frame(width: 80, height: 80) // Adjust size as needed

                Image(systemName: "iphone.gen1")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(AppConstants.primaryOrange)
            }
            .padding(.bottom, AppConstants.verticalSpacing)

            // Welcome Text
            Text("Welcome To Founders Keepers")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

            // Subtitle
            Text("Login with your phone number")
                .font(.body)
                .foregroundColor(AppConstants.secondaryText)
        }
        .padding(.top, AppConstants.largeVerticalSpacing * 2) // Adjust top padding
        .padding(.bottom, AppConstants.largeVerticalSpacing)
    }
}

struct AuthHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthHeaderView()
            .background(AppConstants.darkBackground)
            .previewLayout(.sizeThatFits)
    }
}
