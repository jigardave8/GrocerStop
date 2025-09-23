//
//  Models.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//





import Foundation

struct Promotion: Identifiable {
    let id = UUID()
    let imageName: String
}

struct Category: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
}

struct Product: Identifiable {
    let id = UUID()
    let imageName: String
    let name: String
    let description: String
    let price: String
}

// Make Product conform to Equatable so we can find it in arrays.
extension Product: Equatable {
    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.id == rhs.id
    }
}
