//
//  HomeViewModel.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//

import Foundation
import Combine

// Defines the possible states for our network-dependent view
enum ViewState {
    case loading
    case success([Product])
    case error(String)
}

@MainActor // Ensures that all changes to published properties happen on the main thread
class HomeViewModel: ObservableObject {
    
    @Published var state: ViewState = .loading
    @Published var searchText: String = ""
    
    // --- CORRECTION ---
    // Added searchResults, which is populated by the Combine pipeline below.
    @Published var searchResults: [Product] = []

    // We can still use our local categories for the UI
    let categories = MockDataSource.categories
    let promotions = MockDataSource.promotions
    private var cancellables = Set<AnyCancellable>()
    
    // Computed property to get all products when in the success state
    private var allProducts: [Product] {
        if case .success(let products) = state {
            return products
        }
        return []
    }

    // --- CORRECTION ---
    // Added missing computed property.
    var isSearching: Bool {
        !searchText.isEmpty
    }

    private func applySearchFilter(to products: [Product]) -> [Product] {
        if searchText.isEmpty {
            return products
        }
        return products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }

    // --- CORRECTION ---
    // Added 'featuredProducts' with search filtering.
    var featuredProducts: [Product] {
        // You might have a specific category for featured products from your backend.
        // For now, we'll feature products from the 'fruits' category as an example.
        let featured = allProducts.filter { $0.category == .fruits }
        return applySearchFilter(to: featured)
    }

    var dairyProducts: [Product] {
        let filtered = allProducts.filter { $0.category == .dairy }
        return applySearchFilter(to: filtered)
    }

    var snackProducts: [Product] {
        let filtered = allProducts.filter { $0.category == .snacks }
        return applySearchFilter(to: filtered)
    }
    
    init() {
        // Sets up a Combine pipeline to automatically update searchResults
        // when searchText changes, with a 300ms delay (debounce).
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { [weak self] text -> [Product] in
                guard let self = self, !text.isEmpty else { return [] }
                // Perform a global search across all products
                return self.allProducts.filter {
                    $0.name.localizedCaseInsensitiveContains(text)
                }
            }
            .assign(to: &$searchResults)
    }
    
    // Asynchronous task to fetch products
    func loadProducts() async {
        let result = await NetworkManager.shared.fetchProducts()
        switch result {
        case .success(let products):
            self.state = .success(products)
        case .failure(let error):
            // Use a more user-friendly error message
            self.state = .error("Could not load data. Please check your connection and try again.")
            print("Error loading products: \(error.localizedDescription)")
        }
    }
}
