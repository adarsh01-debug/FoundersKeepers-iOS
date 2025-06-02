//
//  EventProfileScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct EventProfileScreen: View {
    let event: Event
    @State private var requestSent: Bool = false
    @State private var showAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode // To customize back button if needed

    var body: some View {
        ZStack {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all) //

            ScrollView {
                VStack(alignment: .leading, spacing: AppConstants.largeVerticalSpacing) { //
                    // Event Image (Larger than card)
                    Image(systemName: event.imageName) // Placeholder
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 250)
                        .foregroundColor(AppConstants.primaryOrange) //
                        .padding(.top)
                        .frame(maxWidth: .infinity)


                    // Event Details Section
                    VStack(alignment: .leading, spacing: AppConstants.verticalSpacing) { //
                        Text(event.title)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)

                        DetailRow(iconName: "calendar", text: event.dateString)
                        DetailRow(iconName: "location.fill", text: "\(event.location) (\(event.distance))")
                        DetailRow(iconName: "person.2.fill", text: "\(event.attendees) people attending")
                        DetailRow(iconName: "tag.fill", text: "Price: \(event.price)")

                        Divider().background(AppConstants.secondaryText.opacity(0.3)) //

                        Text("About this event")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, 5)

                        Text(event.longDescription)
                            .font(.body)
                            .foregroundColor(AppConstants.secondaryText) //
                            .lineSpacing(5)

                    }
                    .padding(.horizontal, AppConstants.horizontalPadding) //

                    Spacer() // Pushes button to bottom if content is short
                }
                .padding(.bottom, 100) // Space for the sticky button
            }
            
            // Sticky Action Button at the bottom
            VStack {
                Spacer() // Pushes button to the bottom of the ZStack
                Button(action: {
                    if !requestSent {
                        requestSent = true
                        showAlert = true
                        // Add backend call here to notify organizer
                        print("Request to join event: \(event.title) sent.")
                    }
                }) {
                    Text(requestSent ? "Organizer Notified" : "Request to Join Event")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(requestSent ? AppConstants.disabledColor : AppConstants.primaryOrange) //
                        .cornerRadius(10)
                }
                .disabled(requestSent)
                .padding(.horizontal, AppConstants.horizontalPadding) //
                .padding(.bottom, AppConstants.verticalSpacing) //
            }
            .edgesIgnoringSafeArea(.bottom) // Allow button to go to the very bottom edge if needed

        }
        .navigationTitle(event.title) // Sets the title in the navigation bar
        .navigationBarTitleDisplayMode(.inline) // Or .large, depending on preference
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Request Sent!"),
                message: Text("Organizer has been notified. Once they verify, you can access the event group chat."),
                dismissButton: .default(Text("OK"))
            )
        }
         .navigationBarBackButtonHidden(true)
         .toolbar {
             ToolbarItem(placement: .navigationBarLeading) {
                 Button {
                     presentationMode.wrappedValue.dismiss()
                 } label: {
                     Image(systemName: "chevron.left")
                         .foregroundColor(AppConstants.primaryOrange)
                     Text("Events")
                         .foregroundColor(AppConstants.primaryOrange)
                 }
             }
         }
    }
}

// Helper View for detail rows
struct DetailRow: View {
    let iconName: String
    let text: String

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: iconName)
                .font(.callout)
                .foregroundColor(AppConstants.primaryOrange) //
                .frame(width: 25, alignment: .leading)
            Text(text)
                .font(.callout)
                .foregroundColor(AppConstants.secondaryText) //
                .fixedSize(horizontal: false, vertical: true) // Allows text to wrap
        }
    }
}

struct EventProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Wrap in NavigationView for previewing navigation bar elements
            EventProfileScreen(event: Event.sampleEvents[0])
        }
        .preferredColorScheme(.dark)
    }
}
