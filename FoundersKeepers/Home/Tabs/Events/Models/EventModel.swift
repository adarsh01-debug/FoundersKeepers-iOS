//
//  EventModel.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
// Event.swift (or inside EventsScreen.swift)
import SwiftUI

struct Event: Identifiable {
    let id = UUID()
    let title: String
    let dateString: String
    let location: String
    let distance: String
    let attendees: Int
    let price: String
    let imageName: String
    let gradientColors: [Color]
    let longDescription: String // New property

    // Sample Data - MODIFIED with longDescription and translucent gradients
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
              ],
              longDescription: "Join us for an unforgettable night under the stars with live performances from top local bands and artists. Bring your friends, a blanket, and enjoy the vibrant atmosphere. Food and drinks available on site. Don't miss out on the biggest musical event of the summer!"),
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
              ],
              longDescription: "A gathering of the city's best food trucks! Sample a diverse range of culinary delights, from gourmet burgers to exotic street food. Live music and seating areas available. Entry fee includes 3 tasting tokens."),
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
              ],
              longDescription: "Be the first to witness the new 'Modern Perspectives' exhibition featuring stunning works by emerging local artists. Wine and hors d'oeuvres will be served. Mingle with the artists and art enthusiasts."),
        Event(title: "Tech Meetup",
              dateString: "Monday, 7:30 PM",
              location: "Innovation Hub",
              distance: "4.2 miles away",
              attendees: 127,
              price: "$25",
              imageName: "laptopcomputer.circle.fill",
              gradientColors: [
                Color(red: 60/255, green: 30/255, blue: 130/255).opacity(0.30),
                Color(red: 30/255, green: 15/255, blue: 70/255).opacity(0.30)
              ],
              longDescription: "Connect with fellow tech professionals and enthusiasts. This month's topic is 'The Future of AI in Mobile Development', featuring guest speakers from leading tech companies. Networking session included. Ticket includes refreshments.")
    ]
}
