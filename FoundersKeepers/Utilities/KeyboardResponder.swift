//
//  KeyboardResponder.swift
//  FoundersKeepers
//
//  Created by Adarsh on 01/06/25.
//

import Foundation
import SwiftUI
import Combine

import SwiftUI
import Combine

final class KeyboardResponder: ObservableObject {
    @Published var currentHeight: CGFloat = 0

    private var cancellables = Set<AnyCancellable>()

    init() {
        // Listen for keyboard will show notification to get its height
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { notification in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height
            }
            .assign(to: \.currentHeight, on: self)
            .store(in: &cancellables)

        // Listen for keyboard will hide notification to reset height
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .assign(to: \.currentHeight, on: self)
            .store(in: &cancellables)
    }
}
