//
//  CartManager.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//


import Foundation
import SwiftUI

class CartManager: ObservableObject {
    @Published private(set) var items: [Product] = []
    @Published private(set) var total: Double = 0.0

    // Adds a product to the cart. If the product is already there, it won't be added again.
    func addToCart(product: Product) {
        if !items.contains(product) {
            items.append(product)
            recalculateTotal()
        }
    }

    // Removes a product from the cart by its ID.
    func removeFromCart(product: Product) {
        items.removeAll { $0.id == product.id }
        recalculateTotal()
    }
    
    // Recalculates the total price of all items in the cart.
    private func recalculateTotal() {
        total = items.reduce(0) { sum, product in
            // Clean the price string (e.g., "$2.50" -> "2.50") before converting to a Double
            let priceString = product.price.replacingOccurrences(of: "$", with: "")
            let priceValue = Double(priceString) ?? 0.0
            return sum + priceValue
        }
    }
}
