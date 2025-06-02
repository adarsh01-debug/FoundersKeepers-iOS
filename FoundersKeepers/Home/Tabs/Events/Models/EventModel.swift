//
//  EventModel.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI
import CoreLocation // For map coordinates

struct Organizer: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String // Placeholder for organizer's avatar
}

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let dateString: String
    let dateTime: Date // For more precise time handling if needed
    let locationName: String // e.g., "Gandhinagar"
    let fullAddress: String // e.g., "Central Park, NYC"
    let distance: String
    let attendeesCount: Int
    let attendeeImageNames: [String] // For stacked avatars
    let price: String // e.g., "Free" or "$30.00"
    let coverImageName: String // For the large top image
    let gradientColors: [Color] // For the card in EventsScreen (translucent)
    let longDescription: String
    let organizer: Organizer
    let coordinates: CLLocationCoordinate2D // For the map

    // Sample Data - Updated
    static let sampleEvents: [Event] = [
        Event(title: "Party with friends at night - 2022",
              dateString: "THU 26 May, 09:00 PM", // Adjusted format
              dateTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!, // Example date
              locationName: "Gandhinagar",
              fullAddress: "123 Party Lane, Gandhinagar",
              distance: "1.5 miles away",
              attendeesCount: 45, // Total, e.g., 5 shown + 40
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill"], // Placeholder avatars
              price: "$30.00",
              coverImageName: "party.cover", // Placeholder, use an actual image asset name
              gradientColors: [Color(red: 100/255, green: 40/255, blue: 180/255).opacity(0.85), Color(red: 50/255, green: 20/255, blue: 90/255).opacity(0.85)],
              longDescription: "We have a team but still missing a couple of people. Let's play together! We have a team but still missing a couple of people. We have a team but still missing a couple of people.",
              organizer: Organizer(name: "Wade Warren", imageName: "person.crop.circle.badge.checkmark.fill"), // Placeholder
              coordinates: CLLocationCoordinate2D(latitude: 23.2156, longitude: 72.6369)), // Gandhinagar coordinates

        Event(title: "Food Truck Rally",
              dateString: "SAT 28 May, 12:00 PM",
              dateTime: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
              locationName: "Downtown Square",
              fullAddress: "Main Street, Downtown",
              distance: "1.2 miles away",
              attendeesCount: 89,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$15.00",
              coverImageName: "foodtruck.cover",
              gradientColors: [Color(red: 40/255, green: 100/255, blue: 180/255).opacity(0.85), Color(red: 20/255, green: 50/255, blue: 90/255).opacity(0.85)],
              longDescription: "A gathering of the city's best food trucks! Sample a diverse range of culinary delights, from gourmet burgers to exotic street food. Live music and seating areas available.",
              organizer: Organizer(name: "Foodie Group", imageName: "person.crop.circle.badge.plus.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)) // Downtown LA placeholder
    ]
}
