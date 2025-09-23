//
//  GrocerStopApp.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//


import SwiftUI

@main
struct GrocerStopApp: App {
    // Create the cart manager once and pass it down the view hierarchy.
    @StateObject private var cartManager = CartManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartManager) // Make it available to all child views
        }
    }
}
