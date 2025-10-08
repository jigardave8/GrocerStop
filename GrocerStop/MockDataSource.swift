//
//  MockDataSource.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//

import Foundation

// A centralized source for all sample data in the app.
// We still use this for Categories and Promotions which are static.
// The products array is now only used for previews and as a fallback.
struct MockDataSource {
    
    // --- CORRECTION ---
    // The placeholder '<#ProductCategory#>' has been replaced with actual enum cases.
    static let promotions = [
        Promotion(imageName: "promo1", destinationCategory: .fruits),
        Promotion(imageName: "promo2", destinationCategory: .snacks),
        Promotion(imageName: "promo3", destinationCategory: .dairy)
    ]
    
    static let categories = [
        Category(imageName: "fruits", name: .fruits),
        Category(imageName: "vegetables", name: .vegetables),
        Category(imageName: "dairy", name: .dairy),
        Category(imageName: "meat", name: .meat),
        Category(imageName: "bakery", name: .bakery),
        Category(imageName: "snacks", name: .snacks),
        Category(imageName: "beverages", name: .beverages),
        Category(imageName: "frozen", name: .frozen),
        Category(imageName: "staples", name: .staples)
    ]
    
    // CORRECTED: This static list now uses the updated Product initializer
    // It should now only be used for SwiftUI previews or as a fallback if the network fails.
    static let products: [Product] = [
        // Dairy & Bread
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/2229074/pexels-photo-2229074.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Fresh Milk", description: "1L, 3.25% Fat", price: "$2.50", category: .dairy),
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/1359002/pexels-photo-1359002.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "White Bread", description: "500g, Sliced", price: "$3.00", category: .dairy),
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/162712/egg-white-food-protein-162712.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Organic Eggs", description: "12 pack, Free Range", price: "$5.50", category: .dairy),
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/103565/pexels-photo-103565.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Salted Butter", description: "250g Block", price: "$4.00", category: .dairy),
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/827513/pexels-photo-827513.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Cheddar Cheese", description: "400g Block", price: "$6.20", category: .dairy),

        // Snacks & Munchies
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/4039169/pexels-photo-4039169.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Potato Chips", description: "Large Salted", price: "$3.75", category: .snacks),
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/4109128/pexels-photo-4109128.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Dairy Milk Bar", description: "100g Bar", price: "$2.00", category: .snacks),
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/714736/pexels-photo-714736.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Orange Juice", description: "1.5L, Pulp Free", price: "$4.20", category: .snacks),

        // Fruits (Example Data for Category View)
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/209271/pexels-photo-209271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Red Apples", description: "1kg Bag", price: "$4.50", category: .fruits),
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/61127/pexels-photo-61127.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Bananas", description: "Bunch of 5", price: "$2.10", category: .fruits),
        
        // Meat (Example Data for Category View)
        Product(id: UUID(), imageURL: "https://images.pexels.com/photos/65175/pexels-photo-65175.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2", name: "Chicken Breast", description: "500g, Boneless", price: "$9.50", category: .meat)
    ]
}
