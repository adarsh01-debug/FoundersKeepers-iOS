//
//  View+Extension.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import SwiftUI

// Extension to make hideKeyboard() accessible from any View
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
