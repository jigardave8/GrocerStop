//
//  OrderManager.swift
//  GrocerStop
//
//  Created by BitDegree on 08/10/25.
//


import Foundation

class OrderManager: ObservableObject {
    @Published private(set) var pastOrders: [Order] = []
    private let ordersDataKey = "PastOrdersDataKey"

    init() {
        loadOrders()
    }

    func createOrder(from items: [CartItem], total: Double) {
        let newOrder = Order(id: UUID(), orderDate: Date(), items: items, totalPrice: total)
        pastOrders.insert(newOrder, at: 0)
        saveOrders()
    }

    private func saveOrders() {
        do {
            let data = try JSONEncoder().encode(pastOrders)
            UserDefaults.standard.set(data, forKey: ordersDataKey)
        } catch {
            print("Error encoding orders: \(error.localizedDescription)")
        }
    }

    private func loadOrders() {
        guard let data = UserDefaults.standard.data(forKey: ordersDataKey) else { return }
        do {
            pastOrders = try JSONDecoder().decode([Order].self, from: data)
        } catch {
            print("Error decoding orders: \(error.localizedDescription)")
        }
    }
}
