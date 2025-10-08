//
//  CategoryDetailView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import SwiftUI

struct CategoryDetailView: View {
    let category: Category
    let allProducts: [Product]
    
    // Filter products for the selected category
    private var productsForCategory: [Product] {
        return allProducts.filter { $0.category == category.name }
    }
    
    // Define a flexible grid layout for the products
    private let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(productsForCategory) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        // --- CORRECTION ---
                        // The ProductCardView now requires the 'flyingProduct' binding.
                        // We pass a .constant(nil) because the animation is not triggered from this screen.
                        ProductCardView(product: product, flyingProduct: .constant(nil))
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
        .navigationTitle(category.name.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CategoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryDetailView(
                category: Category(imageName: "fruits", name: .fruits),
                allProducts: MockDataSource.products
            )
            .environmentObject(CartManager())
        }
    }
}
