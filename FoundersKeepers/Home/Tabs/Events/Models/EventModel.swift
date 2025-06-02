//
//  EventModel.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let dateString: String
    let location: String
    let distance: String
    let attendees: Int
    let price: String // e.g., "Free" or "$15"
    let imageName: String // Name of an image asset or SF Symbol
    let gradientColors: [Color]

    // Sample Data - MODIFIED with .opacity(0.85) for translucency
    static let sampleEvents: [Event] = [
        Event(title: "Summer Music Festival",
              dateString: "Tomorrow, 7:00 PM",
              location: "Central Park, NYC",
              distance: "2.5 miles away",
              attendees: 245,
              price: "Free",
              imageName: "music.mic.circle.fill",
              gradientColors: [
                Color(red: 100/255, green: 40/255, blue: 180/255).opacity(0.30),
                Color(red: 50/255, green: 20/255, blue: 90/255).opacity(0.30)
              ]), // Purpleish
        Event(title: "Food Truck Rally",
              dateString: "Saturday, 12:00 PM",
              location: "Downtown Square",
              distance: "1.2 miles away",
              attendees: 89,
              price: "$15",
              imageName: "car.circle.fill",
              gradientColors: [
                Color(red: 40/255, green: 100/255, blue: 180/255).opacity(0.30),
                Color(red: 20/255, green: 50/255, blue: 90/255).opacity(0.30)
              ]), // Bluish
        Event(title: "Art Gallery Opening",
              dateString: "Sunday, 6:00 PM",
              location: "Gallery District",
              distance: "3.1 miles away",
              attendees: 52,
              price: "Free",
              imageName: "photo.artframe.circle.fill",
              gradientColors: [
                Color(red: 40/255, green: 180/255, blue: 100/255).opacity(0.30),
                Color(red: 20/255, green: 90/255, blue: 50/255).opacity(0.30)
              ]), // Greenish
        Event(title: "Tech Meetup",
              dateString: "Monday, 7:30 PM",
              location: "Innovation Hub",
              distance: "4.2 miles away",
              attendees: 127,
              price: "$25",
              imageName: "laptopcomputer",
              gradientColors: [
                Color(red: 60/255, green: 30/255, blue: 130/255).opacity(0.30),
                Color(red: 30/255, green: 15/255, blue: 70/255).opacity(0.30)
              ])
    ]
}
