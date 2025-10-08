//
//  HapticsManager.swift
//  GrocerStop
//
//  Created by BitDegree on 08/10/25.
//



import UIKit

// A simple, reusable manager for triggering haptic feedback.
final class HapticsManager {
    static let shared = HapticsManager()
    private init() {}

    // Triggers a notification-style haptic feedback.
    public func notify(_ type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }

    // Triggers an impact-style haptic feedback.
    public func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        DispatchQueue.main.async {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        }
    }
}
