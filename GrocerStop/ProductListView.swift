//
//  ProductListView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import SwiftUI

struct ProductListView: View {
    let products: [Product]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(products) { product in
                    ProductCardView(product: product)
                }
            }
        }
    }
}

struct ProductCardView: View {
    @EnvironmentObject var cartManager: CartManager
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Remember to add images named "milk", etc., to Assets.xcassets
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 120)
                .clipped()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding(.bottom, 4)

            Text(product.name)
                .font(.subheadline)
                .fontWeight(.medium)
                .lineLimit(1)
            
            Text(product.description)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(1)

            HStack {
                Text(product.price)
                    .font(.subheadline)
                    .fontWeight(.bold)
                Spacer()
                Button(action: {
                    cartManager.addToCart(product: product)
                }) {
                    Text("Add")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 6)
                        .background(Color.green.opacity(0.15))
                        .foregroundColor(.green)
                        .cornerRadius(8)
                }
            }
        }
        .frame(width: 150)
        .padding(10)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}


struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(products: [
            Product(imageName: "milk", name: "Milk", description: "1L", price: "$2.50")
        ])
        .environmentObject(CartManager())
        .previewLayout(.sizeThatFits)
    }
}
