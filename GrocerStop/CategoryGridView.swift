//
//  CategoryGridView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//




import SwiftUI

struct CategoryGridView: View {
    let categories: [Category]
    
    private let gridLayout: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridLayout, spacing: 10) {
                 ForEach(categories) { category in
                    CategoryView(category: category)
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
            // Remember to add images named "fruits", etc., to Assets.xcassets
            Image(category.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .cornerRadius(10)
                .padding(4)

            Text(category.name)
                .font(.caption)
                .multilineTextAlignment(.center)
                .lineLimit(1)
        }
        .frame(width: 100)
    }
}

struct CategoryGridView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryGridView(categories: [
            Category(imageName: "fruits", name: "Fruits"),
            Category(imageName: "vegetables", name: "Vegetables"),
            Category(imageName: "dairy", name: "Dairy")
        ])
        .previewLayout(.sizeThatFits)
    }
}
