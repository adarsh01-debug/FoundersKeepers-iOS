//
//  TermsAndPrivacyView.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import SwiftUI

struct TermsAndPrivacyView: View {
    var body: some View {
        VStack {
            // Use Text with Markdown to create inline links.
            // The format is [Link Text](link_url_placeholder)
            Text("By continuing, you agree to our [Terms of Service](terms_of_service_url) and [Privacy Policy](privacy_policy_url)")
                .font(.footnote)
                .foregroundColor(AppConstants.secondaryText) // Apply main text color
                .multilineTextAlignment(.center) // Keep center alignment for the block
                // Use .accentColor for the default link color, or override with foregroundColor
                .accentColor(AppConstants.linkColor) // This sets the color for Markdown links

                // Custom URL handling for Markdown links:
                // This allows you to intercept the URLs and perform actions (e.g., open Safari, show an in-app browser).
                .environment(\.openURL, OpenURLAction { url in
                    if url.absoluteString == "terms_of_service_url" {
                        print("Terms of Service link tapped!")
                        // Replace with your actual Terms of Service URL
                        if let realURL = URL(string: "https://www.example.com/terms-of-service") {
                            // You can open in Safari:
                            UIApplication.shared.open(realURL)
                            // Or use an in-app web view (like SafariServices SFSafariViewController)
                        }
                    } else if url.absoluteString == "privacy_policy_url" {
                        print("Privacy Policy link tapped!")
                        // Replace with your actual Privacy Policy URL
                        if let realURL = URL(string: "https://www.example.com/privacy-policy") {
                            UIApplication.shared.open(realURL)
                        }
                    }
                    return .handled // Indicate that you've handled the URL opening
                })
        }
        .padding(.horizontal, AppConstants.horizontalPadding * 2) // More padding for this text
        .padding(.top, AppConstants.largeVerticalSpacing)
    }
}

struct TermsAndPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndPrivacyView()
            .background(AppConstants.darkBackground)
            .previewLayout(.sizeThatFits)
    }
}
