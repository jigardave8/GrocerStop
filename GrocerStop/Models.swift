//
//  Models.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//


import Foundation

// Enum for Product Categories to ensure type safety.
enum ProductCategory: String, Codable, CaseIterable, Identifiable {
    case dairy = "Dairy & Bread", snacks = "Snacks & Munchies", fruits = "Fruits"
    case vegetables = "Vegetables", meat = "Meat", bakery = "Bakery"
    case beverages = "Beverages", frozen = "Frozen", staples = "Staples"
    case featured = "Featured Products"
    var id: String { self.rawValue }
}

struct Promotion: Identifiable, Codable, Hashable {
    let id = UUID()
    let imageName: String
    let destinationCategory: ProductCategory
}

struct Category: Identifiable, Equatable {
    let id = UUID()
    let imageName: String
    let name: ProductCategory
}

struct Product: Identifiable, Codable, Hashable {
    @CodableUUID var id: UUID
    let imageURL: String?
    let name: String
    let description: String
    let price: String
    let category: ProductCategory
}

@propertyWrapper
struct CodableUUID: Codable, Hashable {
    var wrappedValue: UUID
    init(wrappedValue: UUID) { self.wrappedValue = wrappedValue }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let uuidString = try container.decode(String.self)
        guard let uuid = UUID(uuidString: uuidString) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid UUID string")
        }
        self.wrappedValue = uuid
    }
    
    // --- CORRECTION ---
    // Added the encode(to:) method to make the type fully conform to Codable.
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue.uuidString)
    }
}


struct CartItem: Identifiable, Codable, Hashable {
    var id: UUID { product.id }
    let product: Product
    var quantity: Int
}

struct Order: Identifiable, Codable, Hashable {
    let id: UUID
    let orderDate: Date
    let items: [CartItem]
    let totalPrice: Double
    
    var formattedOrderDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: orderDate)
    }
}
