//
//  CartManager.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import Foundation

class CartManager: ObservableObject {
    @Published private(set) var items: [CartItem] = []
    @Published private(set) var total: Double = 0.0
    private let cartDataKey = "CartDataKey"

    init() {
        loadCart()
    }

    func addToCart(product: Product, quantity: Int = 1) {
        if let index = items.firstIndex(where: { $0.id == product.id }) {
            items[index].quantity += quantity
        } else {
            items.append(CartItem(product: product, quantity: quantity))
        }
        saveAndRecalculate()
    }

    func incrementQuantity(for item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity += 1
            saveAndRecalculate()
        }
    }

    func decrementQuantity(for item: CartItem) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
            saveAndRecalculate()
        }
    }

    func removeItem(for item: CartItem) {
        items.removeAll { $0.id == item.id }
        saveAndRecalculate()
    }

    func clearCart() {
        items.removeAll()
        saveAndRecalculate()
    }

    private func saveCart() {
        do {
            let data = try JSONEncoder().encode(items)
            UserDefaults.standard.set(data, forKey: cartDataKey)
        } catch {
            print("Error encoding cart items: \(error.localizedDescription)")
        }
    }

    private func loadCart() {
        guard let data = UserDefaults.standard.data(forKey: cartDataKey) else { return }
        do {
            items = try JSONDecoder().decode([CartItem].self, from: data)
            recalculateTotal()
        } catch {
            print("Error decoding cart items: \(error.localizedDescription)")
        }
    }
    
    private func recalculateTotal() {
        total = items.reduce(0) { sum, item in
            let priceString = item.product.price.replacingOccurrences(of: "$", with: "")
            let priceValue = Double(priceString) ?? 0.0
            return sum + (priceValue * Double(item.quantity))
        }
    }

    private func saveAndRecalculate() {
        recalculateTotal()
        saveCart()
    }
}
