//
//  GrocerStopApp.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import SwiftUI

@main
struct GrocerStopApp: App {
    @StateObject private var cartManager = CartManager()
    @StateObject private var orderManager = OrderManager()
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = AppStorageManager.hasCompletedOnboarding

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                ContentView().environmentObject(cartManager).environmentObject(orderManager)
            } else {
                OnboardingView()
            }
        }
    }
}
