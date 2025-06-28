//
//  EventCardView.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct EventCardView: View {
    let event: Event // Assumes 'Event' model has 'fullAddress' and 'distance'

    var body: some View {
        ZStack(alignment: .bottomTrailing) { // Align children to the bottom-trailing edge
            // Main content area (image + text details)
            HStack(spacing: 15) {
                Image(systemName: event.coverImageName) // Using SF Symbols as placeholders
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40) // Adjusted from 60x60 in previous version to match image
                    .padding(10)
                    .background(Color.white.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(AppConstants.primaryOrange)

                VStack(alignment: .leading, spacing: 6) {
                    Text(event.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Text("\(event.dateString)")
                        .font(.subheadline)
                        .foregroundColor(Color.white.opacity(0.9))

                    Text("\(event.fullAddress) • \(event.distance)")
                        .font(.caption)
                        .foregroundColor(Color.white.opacity(0.7))
                        .lineLimit(1)

                    HStack {
                        Image(systemName: "person.2.fill")
                        Text("\(event.attendeesCount) attending")
                    }
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.7))
                }
                // Add a Spacer here to push the VStack content to the left,
                // allowing the price tag to overlay correctly in the ZStack's bottomTrailing.
                Spacer()
            }
            // This padding is for the content within the ZStack, before the price tag overlay.
            .padding(AppConstants.verticalSpacing)


            // Price Tag - will be aligned to bottomTrailing by the ZStack
            Text(event.price)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(event.price.lowercased() == "free" ? Color.green.opacity(0.9) : AppConstants.primaryOrange)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.black.opacity(0.25)) // Slightly increased opacity for better visibility
                .clipShape(Capsule())
                .padding([.bottom, .trailing], AppConstants.verticalSpacing / 1.5)
        }
        // These modifiers apply to the ZStack, defining the card's overall appearance
        .background(
            LinearGradient(gradient: Gradient(colors: event.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(15)
        .shadow(color: event.gradientColors.first?.opacity(0.4) ?? .black, radius: 5, x: 0, y: 3)
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        EventCardView(event: Event.sampleEvents[0])
            .padding()
            .background(AppConstants.darkBackground)
            .previewLayout(.sizeThatFits)
    }
}
