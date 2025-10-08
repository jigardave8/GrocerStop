//
//  ContentView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//


import SwiftUI

// This struct uniquely identifies a flying animation instance.
struct FlyingProduct: Identifiable, Equatable {
    let id: UUID
    let product: Product
}

// PreferenceKey to find the global position of the cart tab icon.
struct CartTabPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        // We only care about the first non-zero value.
        if value == .zero {
            value = nextValue()
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var flyingProduct: FlyingProduct?
    @State private var cartTabPosition: CGPoint = .zero

    var body: some View {
        TabView {
            // --- Home Tab ---
            HomeView(flyingProduct: $flyingProduct)
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            // --- Cart Tab ---
            CartView()
                .tabItem {
                    Label {
                        Text("Cart")
                    } icon: {
                        Image(systemName: "cart.fill")
                            .background(
                                GeometryReader { geo in
                                    Color.clear.preference(
                                        key: CartTabPreferenceKey.self,
                                        value: CGPoint(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY)
                                    )
                                }
                            )
                    }
                }
                .badge(cartManager.items.count > 0 ? "\(cartManager.items.count)" : nil)

            // --- Other Tabs ---
            Text("Placeholder for future functionality.")
                .font(.title3)
                .tabItem { Label("Search", systemImage: "magnifyingglass") }
            
            AccountView()
                .tabItem { Label("Account", systemImage: "person.fill") }
        }
        .onPreferenceChange(CartTabPreferenceKey.self) { position in
            if position != .zero {
                cartTabPosition = position
            }
        }
        .overlay(alignment: .topLeading) {
            if let flyingItem = flyingProduct {
                // --- CORRECTION ---
                // The parameter label for the completion handler is 'onAnimationFinished'.
                ProductFlyAnimationView(product: flyingItem.product, endPosition: cartTabPosition, onAnimationFinished: {
                    self.flyingProduct = nil
                })
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CartManager())
    }
}
