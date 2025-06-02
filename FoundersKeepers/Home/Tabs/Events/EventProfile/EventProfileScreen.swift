//
//  EventProfileScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI
import MapKit

struct EventProfileScreen: View {
    let event: Event
    @State private var requestSent: Bool = false
    @State private var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack(alignment: .bottom) {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Event Image (as per previous "standard nav bar" version)
                    Image(systemName: event.coverImageName) // Or Image(event.coverImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .clipped()
                        .cornerRadius(10)
                        .padding(.horizontal, AppConstants.horizontalPadding)
                        .padding(.top, AppConstants.verticalSpacing)

                    // Details Box, About Section, OrganizersAttendeesView, Location Section
                    // (These helper views and their content remain as previously defined)
                    EventDetailsBox(event: event)
                        .padding([.horizontal, .top], AppConstants.horizontalPadding)

                    SectionView(title: "About") {
                        Text(event.longDescription)
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(AppConstants.secondaryText)
                            .lineSpacing(5)
                    }

                    OrganizersAttendeesView(organizer: event.organizer, attendees: event.attendeeImageNames, totalAttendees: event.attendeesCount)
                        .padding(.top, AppConstants.verticalSpacing)

                    SectionView(title: "Location") {
                        Map(coordinateRegion: .constant(MKCoordinateRegion(
                            center: event.coordinates,
                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                        )), annotationItems: [IdentifiablePlace(coord: event.coordinates)]) { place in
                            MapMarker(coordinate: place.coord, tint: AppConstants.primaryOrange)
                        }
                        .frame(height: 200)
                        .cornerRadius(10)
                        .overlay(
                            Button(action: {
                                // Action to open in Maps app
                                let coordinate = event.coordinates
                                let placemark = MKPlacemark(coordinate: coordinate)
                                let mapItem = MKMapItem(placemark: placemark)
                                mapItem.name = event.title // Set the pin name to the event title
                                
                                // Define launch options if you want to show directions, etc.
                                // For simply showing the location, no specific options are strictly needed.
                                // Example: For driving directions
                                // let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                                // mapItem.openInMaps(launchOptions: launchOptions)
                                
                                // Open the location in Apple Maps
                                mapItem.openInMaps()
                            }) {
                                Text("See Location")
                                    .font(.caption.weight(.bold))
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.black.opacity(0.6)) // Slightly darker for better contrast
                                    .cornerRadius(8)
                            }
                                .padding(8), // Padding for the button itself from the map edge
                            alignment: .topLeading // Position button at top-left of map
                        )
                    }
                    
                    Spacer(minLength: 100) // Space for sticky button
                }
            }
            .scrollIndicators(.hidden)

            // Sticky Action Button (remains the same)
            VStack {
                Spacer()
                Button(action: {
                    if !requestSent {
                        requestSent = true
                        showAlert = true
                        print("Request to join event: \(event.title) sent.")
                    }
                }) {
                    Text(requestSent ? "Organizer Notified" : "Request to Join Event")
                        .font(.headline.weight(.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(requestSent ? AppConstants.disabledColor : AppConstants.primaryOrange)
                        .cornerRadius(12)
                }
                .disabled(requestSent)
                .padding(.horizontal, AppConstants.horizontalPadding)
                .padding(.bottom)
            }
        }
        .navigationTitle(event.title) // Set the title for the navigation bar
        .navigationBarTitleDisplayMode(.inline) // Use inline display mode
        .navigationBarBackButtonHidden(true) // This is crucial: Hides the default system "< Back" button
        .toolbar { // Defines custom toolbar items
            ToolbarItem(placement: .navigationBarLeading) { // Places item in the leading (back button) position
                Button {
                    presentationMode.wrappedValue.dismiss() // Action to dismiss the current view
                } label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .foregroundColor(AppConstants.primaryOrange)
                        Text("Events") // Or "Back", or use event.organizer.name etc.
                            .foregroundColor(AppConstants.primaryOrange)
                    }
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button { } label: {
                    Image(systemName: "heart")
                        .foregroundColor(AppConstants.primaryOrange)
                }
            }
        }
        .customAlert(
            isPresented: $showAlert,
            iconName: "paperplane.fill", // Or "checkmark.circle.fill" for generic success
            iconColor: AppConstants.successGreen, //
            title: "Request Sent!",
            message: "Organizer has been notified. Once they verify, you can access the event group chat.",
            primaryButtonTitle: "OK",
            primaryButtonAction: {
                // isPresented will be set to false by CustomAlertView's button action
            }
            // No secondary button needed for this specific alert
        )
    }
}

// Helper View for consistent section styling
struct SectionView<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: AppConstants.verticalSpacing / 2) {
            Text(title)
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
            content
        }
        .padding(AppConstants.horizontalPadding)
    }
}


// Helper for Details Box
struct EventDetailsBox: View {
    let event: Event
    var body: some View {
        VStack(alignment: .leading, spacing: AppConstants.verticalSpacing) {
            HStack {
                Text(event.title)
                    .font(.title2.weight(.bold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                Spacer()
                Text(event.price)
                    .font(.title3.weight(.bold))
                    .foregroundColor(AppConstants.primaryOrange)
            }
            IconTextRow(iconName: "location.fill", text: event.locationName)
            IconTextRow(iconName: "calendar", text: event.dateString)
            
            HStack {
                Image(systemName: "person.3.fill")
                    .foregroundColor(.white)
                StackedAttendeesView(imageNames: Array(event.attendeeImageNames.prefix(3)), totalCount: event.attendeesCount)
            }
        }
        .padding(AppConstants.verticalSpacing)
        .background(AppConstants.eventProfileSectionBackground)
        .cornerRadius(12)
    }
}

// Helper for Icon + Text rows in Details Box
struct IconTextRow: View {
    let iconName: String
    let text: String
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: iconName)
                .font(.callout)
                .foregroundColor(AppConstants.secondaryText)
                .frame(width: 20, height: 20, alignment: .center)
            Text(text)
                .font(.subheadline)
                .foregroundColor(AppConstants.secondaryText)
        }
    }
}

// Helper for Stacked Attendee Avatars
struct StackedAttendeesView: View {
    let imageNames: [String]
    let totalCount: Int
    private let overlap: CGFloat = 10
    private let avatarSize: CGFloat = 24

    var body: some View {
        HStack(spacing: -overlap) { // Negative spacing for overlap
            ForEach(0..<imageNames.count, id: \.self) { index in
                Image(systemName: imageNames[index]) // Placeholder
                    .resizable()
                    .foregroundStyle(.white)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: avatarSize, height: avatarSize)
                    .overlay(Circle().stroke(AppConstants.darkBackground, lineWidth: 1))
                    .zIndex(Double(imageNames.count - index)) // Ensure correct overlap order
            }
            if totalCount > imageNames.count {
                Text("+\(totalCount - imageNames.count)")
                    .font(.caption.weight(.semibold))
                    .foregroundColor(.white)
                    .frame(width: avatarSize, height: avatarSize)
                    .background(AppConstants.primaryOrange.opacity(0.8))
                    .clipShape(Circle())
                    .overlay(Circle().stroke(AppConstants.darkBackground, lineWidth: 1))
                    .zIndex(0) // Ensure it's at the "back" of the displayed images
            }
        }
    }
}

// Helper for Organizers and Attendees Section
struct OrganizersAttendeesView: View {
    let organizer: Organizer
    let attendees: [String] // image names
    let totalAttendees: Int

    var body: some View {
        VStack(alignment: .leading) {
            Text("Organizers and Attendees")
                .font(.title3.weight(.semibold))
                .foregroundColor(.white)
            
            HStack {
                Image(systemName: organizer.imageName) // Placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.white)
                VStack(alignment: .leading) {
                    Text(organizer.name)
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Organizer")
                        .font(.caption)
                        .foregroundColor(AppConstants.secondaryText)
                }
                Spacer()
                StackedAttendeesView(imageNames: Array(attendees.prefix(2)), totalCount: totalAttendees) // Show fewer here, e.g., +15
                
                Button { /* Action for chat icon */ } label: {
                    Image(systemName: "message.badge.filled.fill")
                        .font(.title2)
                        .foregroundColor(AppConstants.primaryOrange)
                }
            }
        }
        .padding(AppConstants.verticalSpacing)
        .background(AppConstants.eventProfileSectionBackground)
        .cornerRadius(12)
        .padding(.horizontal, AppConstants.horizontalPadding)
    }
}

// For Map annotation
struct IdentifiablePlace: Identifiable {
    let id = UUID()
    let coord: CLLocationCoordinate2D
}


struct EventProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        EventProfileScreen(event: Event.sampleEvents[0])
            .preferredColorScheme(.dark)
    }
}
