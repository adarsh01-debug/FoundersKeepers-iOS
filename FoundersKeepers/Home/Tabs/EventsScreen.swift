//
//  EventsScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct EventsScreen: View {
    var body: some View {
        ZStack {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all) //
            VStack {
                Text("Events")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, AppConstants.largeVerticalSpacing) //

                Spacer()

                Text("Upcoming events will be listed here.")
                    .font(.title3)
                    .foregroundColor(AppConstants.secondaryText) //
                
                Spacer()
            }
        }
    }
}

struct EventsScreen_Previews: PreviewProvider {
    static var previews: some View {
        EventsScreen()
    }
}
