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
        Event(title: "Filmmaker's Networking Night",
              dateString: "THU 26 May, 09:00 PM",
              dateTime: Calendar.current.date(byAdding: .day, value: 1, to: Date())!,
              locationName: "Gandhinagar",
              fullAddress: "123 Film Lane, Gandhinagar",
              distance: "1.5 miles away",
              attendeesCount: 45,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$30.00",
              coverImageName: "event-balloons",
              gradientColors: [Color(red: 100/255, green: 40/255, blue: 180/255).opacity(0.30), Color(red: 50/255, green: 20/255, blue: 90/255).opacity(0.30)],
              longDescription: "Connect with fellow filmmakers, share ideas, and find collaborators for your next project. Whether you're a director, screenwriter, or cinematographer, this is the place to build your network and spark creative partnerships.",
              organizer: Organizer(name: "Wade Warren", imageName: "person.crop.circle.badge.checkmark.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 23.2156, longitude: 72.6369)),

        Event(title: "Creator's Food Fest",
              dateString: "SAT 28 May, 12:00 PM",
              dateTime: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
              locationName: "Downtown Square",
              fullAddress: "Main Street, Downtown",
              distance: "1.2 miles away",
              attendeesCount: 89,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$15.00",
              coverImageName: "event-balloons",
              gradientColors: [Color(red: 40/255, green: 100/255, blue: 180/255).opacity(0.30), Color(red: 20/255, green: 50/255, blue: 90/255).opacity(0.30)],
              longDescription: "A gathering of YouTubers and content creators to network, share tips, and enjoy delicious food from local trucks. Bring your camera and appetite for a day of collaboration and culinary delights!",
              organizer: Organizer(name: "Foodie Group", imageName: "person.crop.circle.badge.plus.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)),

        Event(title: "Screenwriting Masterclass",
              dateString: "MON 30 May, 10:00 AM",
              dateTime: Calendar.current.date(byAdding: .day, value: 5, to: Date())!,
              locationName: "Hollywood Studios",
              fullAddress: "456 Script Avenue, Hollywood",
              distance: "2.0 miles away",
              attendeesCount: 30,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$50.00",
              coverImageName: "event-balloons",
              gradientColors: [Color(red: 200/255, green: 100/255, blue: 50/255).opacity(0.30), Color(red: 100/255, green: 50/255, blue: 25/255).opacity(0.30)],
              longDescription: "Learn the art of crafting compelling scripts from industry veterans. This masterclass covers structure, character development, and dialogue—perfect for aspiring screenwriters looking to break into the industry.",
              organizer: Organizer(name: "Script Masters", imageName: "person.crop.circle.badge.checkmark.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 34.1021, longitude: -118.3268)),

        Event(title: "YouTube Growth Hacking Workshop",
              dateString: "TUE 31 May, 02:00 PM",
              dateTime: Calendar.current.date(byAdding: .day, value: 6, to: Date())!,
              locationName: "Silicon Valley Tech Hub",
              fullAddress: "789 Innovation Drive, Silicon Valley",
              distance: "3.5 miles away",
              attendeesCount: 60,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$25.00",
              coverImageName: "youtube.cover",
              gradientColors: [Color(red: 255/255, green: 0/255, blue: 0/255).opacity(0.30), Color(red: 128/255, green: 0/255, blue: 0/255).opacity(0.30)],
              longDescription: "Discover strategies to grow your channel, increase engagement, and monetize your content. Learn from successful YouTubers and industry experts in this hands-on workshop designed for creators at all levels.",
              organizer: Organizer(name: "Growth Hackers", imageName: "person.crop.circle.badge.plus.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 37.3875, longitude: -122.0575)),

        Event(title: "SaaS Startup Bootcamp",
              dateString: "WED 01 Jun, 09:00 AM",
              dateTime: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
              locationName: "San Francisco Bay Area",
              fullAddress: "101 Startup Street, San Francisco",
              distance: "4.0 miles away",
              attendeesCount: 50,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$100.00",
              coverImageName: "saas.cover",
              gradientColors: [Color(red: 0/255, green: 128/255, blue: 255/255).opacity(0.30), Color(red: 0/255, green: 64/255, blue: 128/255).opacity(0.30)],
              longDescription: "An intensive program for entrepreneurs to build and launch their software-as-a-service businesses. Learn about product development, marketing, and funding from experienced founders and investors.",
              organizer: Organizer(name: "Startup Incubator", imageName: "person.crop.circle.badge.checkmark.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)),

        Event(title: "TEDx Innovation Talks",
              dateString: "THU 02 Jun, 07:00 PM",
              dateTime: Calendar.current.date(byAdding: .day, value: 8, to: Date())!,
              locationName: "New York City",
              fullAddress: "555 Inspiration Blvd, NYC",
              distance: "5.0 miles away",
              attendeesCount: 100,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$20.00",
              coverImageName: "tedx.cover",
              gradientColors: [Color(red: 255/255, green: 69/255, blue: 0/255).opacity(0.30), Color(red: 128/255, green: 34/255, blue: 0/255).opacity(0.30)],
              longDescription: "Inspiring talks from thought leaders on the latest trends in technology, design, and creativity. Be part of the conversation and get inspired by ideas worth spreading.",
              organizer: Organizer(name: "TEDx Organizers", imageName: "person.crop.circle.badge.plus.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)),

        Event(title: "Cinematography Techniques Workshop",
              dateString: "FRI 03 Jun, 01:00 PM",
              dateTime: Calendar.current.date(byAdding: .day, value: 9, to: Date())!,
              locationName: "Los Angeles Film School",
              fullAddress: "222 Camera Street, LA",
              distance: "2.5 miles away",
              attendeesCount: 25,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$75.00",
              coverImageName: "cinematography.cover",
              gradientColors: [Color(red: 128/255, green: 0/255, blue: 128/255).opacity(0.30), Color(red: 64/255, green: 0/255, blue: 64/255).opacity(0.30)],
              longDescription: "Hands-on training in camera work, lighting, and visual storytelling. Perfect for aspiring cinematographers and filmmakers looking to enhance their technical skills.",
              organizer: Organizer(name: "Film School Faculty", imageName: "person.crop.circle.badge.checkmark.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)),

        Event(title: "Content Creator's Branding Clinic",
              dateString: "SAT 04 Jun, 11:00 AM",
              dateTime: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
              locationName: "Online (Virtual Event)",
              fullAddress: "Virtual Event",
              distance: "N/A",
              attendeesCount: 150,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill"],
              price: "Free",
              coverImageName: "branding.cover",
              gradientColors: [Color(red: 0/255, green: 255/255, blue: 0/255).opacity(0.30), Color(red: 0/255, green: 128/255, blue: 0/255).opacity(0.30)],
              longDescription: "Learn how to build a strong personal brand and stand out in the crowded digital landscape. Expert tips on branding, marketing, and audience engagement for content creators.",
              organizer: Organizer(name: "Branding Experts", imageName: "person.crop.circle.badge.plus.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437)),

        Event(title: "Entrepreneur's Pitch Night",
              dateString: "SUN 05 Jun, 06:00 PM",
              dateTime: Calendar.current.date(byAdding: .day, value: 11, to: Date())!,
              locationName: "Seattle Startup Hub",
              fullAddress: "321 Pitch Avenue, Seattle",
              distance: "3.0 miles away",
              attendeesCount: 75,
              attendeeImageNames: ["person.crop.circle.fill", "person.crop.circle.fill", "person.crop.circle.fill"],
              price: "$10.00",
              coverImageName: "pitch.cover",
              gradientColors: [Color(red: 255/255, green: 165/255, blue: 0/255).opacity(0.30), Color(red: 128/255, green: 82/255, blue: 0/255).opacity(0.30)],
              longDescription: "Present your business idea to a panel of investors and get valuable feedback. A great opportunity to network, refine your pitch, and potentially secure funding for your startup.",
              organizer: Organizer(name: "Startup Hub", imageName: "person.crop.circle.badge.checkmark.fill"),
              coordinates: CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321))
    ]
}
