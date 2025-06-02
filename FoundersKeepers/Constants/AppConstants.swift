//
//  AppConstants.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import Foundation
import SwiftUI

struct AppConstants {
    // MARK: - Colors
    static let primaryOrange = Color(red: 255/255, green: 105/255, blue: 0/255) // The orange accent color
    static let primaryOrange_alpha05 = primaryOrange.opacity(0.05)
    static let darkBackground = Color.black // The main background color
    static let secondaryText = Color.white.opacity(0.7) // For greyish text
    static let disabledColor = Color.gray
    static let linkColor = Color(red: 0/255, green: 122/255, blue: 255/255) // A typical blue for links
    static let exploreCardViewBgColor = Color(red: 39/255, green: 30/255, blue: 40/255)
    
    static let eventProfileSectionBackground = Color(white: 0.1) // Slightly lighter than pure black
    static let successGreen = Color.green

    // MARK: - Paddings & Spacings
    static let horizontalPadding: CGFloat = 20
    static let verticalSpacing: CGFloat = 15
    static let largeVerticalSpacing: CGFloat = 30
}
