//
//  CategoryGridView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//


import SwiftUI

struct CategoryGridView: View {
    let categories: [Category]
    
    // --- CORRECTION ---
    // This property is needed to pass down to the detail view.
    let allProducts: [Product]

    private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridLayout, spacing: 10) {
                 ForEach(categories) { category in
                    // Each CategoryView is now a NavigationLink
                    NavigationLink(destination: CategoryDetailView(category: category, allProducts: allProducts)) {
                        CategoryView(category: category)
                    }
                    .buttonStyle(PlainButtonStyle())
                 }
            }
            .padding(.vertical, 5)
        }
        .frame(height: 250)
    }
}

struct CategoryView: View {
    let category: Category
    
    var body: some View {
        VStack {
            Image(category.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .cornerRadius(10)
                .padding(4)

            Text(category.name.rawValue)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
        .frame(width: 100)
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CategoryGridView(categories: MockDataSource.categories, allProducts: MockDataSource.products)
                .environmentObject(CartManager())
        }
    }
}
