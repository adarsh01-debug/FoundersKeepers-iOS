//
//  ChatsScreen.swift
//  FoundersKeepers
//
//  Created by Adarsh on 02/06/25.
//

import Foundation
import SwiftUI

struct ChatsScreen: View {
    var body: some View {
        ZStack {
            AppConstants.darkBackground.edgesIgnoringSafeArea(.all) //
            VStack {
                Text("Chats")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, AppConstants.largeVerticalSpacing) //

                Spacer()

                Text("Your conversations will appear here.")
                    .font(.title3)
                    .foregroundColor(AppConstants.secondaryText) //
                
                Spacer()
            }
        }
    }
}

struct ChatsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatsScreen()
    }
}
