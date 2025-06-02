//
//  EventCardView.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

// FoundersKeepers/UI/EventCardView.swift
import SwiftUI

struct EventCardView: View {
    let event: Event // Assumes 'Event' model has 'fullAddress' and 'distance'

    var body: some View {
        HStack(spacing: 15) {
            // Event Image
            Image(systemName: event.coverImageName) // Using SF Symbols as placeholders
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
                .padding(10)
                .background(Color.white.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundColor(AppConstants.primaryOrange)

            VStack(alignment: .leading, spacing: 6) {
                Text(event.title)
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .lineLimit(1)

                Text("\(event.dateString)")
                    .font(.subheadline)
                    .foregroundColor(Color.white.opacity(0.9))

                // Corrected line: Use event.fullAddress
                Text("\(event.fullAddress) • \(event.distance)")
                    .font(.caption)
                    .foregroundColor(Color.white.opacity(0.7))
                    .lineLimit(1)


                HStack {
                    Image(systemName: "person.2.fill")
                    Text("\(event.attendeesCount) attending") // Assuming attendeesCount is the correct property
                }
                .font(.caption)
                .foregroundColor(Color.white.opacity(0.7))
            }

            Spacer() // Pushes price tag to the right

            // Price Tag
            Text(event.price)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(event.price.lowercased() == "free" ? Color.green.opacity(0.9) : AppConstants.primaryOrange)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.black.opacity(0.2))
                .clipShape(Capsule())
        }
        .padding(AppConstants.verticalSpacing)
        .background(
            LinearGradient(gradient: Gradient(colors: event.gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(15)
        .shadow(color: event.gradientColors.first?.opacity(0.4) ?? .black, radius: 5, x: 0, y: 3)
    }
}

struct EventCardView_Previews: PreviewProvider {
    static var previews: some View {
        // Ensure Event.sampleEvents[0] matches the updated Event model structure
        EventCardView(event: Event.sampleEvents[0])
            .padding()
            .background(AppConstants.darkBackground)
            .previewLayout(.sizeThatFits)
    }
}
