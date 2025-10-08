//
//  ProductListView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import SwiftUI

struct ProductListView: View {
    let products: [Product]
    @Binding var flyingProduct: FlyingProduct? // State for animation

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 15) {
                ForEach(products) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductCardView(product: product, flyingProduct: $flyingProduct)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct ProductCardView: View {
    @EnvironmentObject var cartManager: CartManager
    let product: Product
    @Binding var flyingProduct: FlyingProduct?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: product.imageURL ?? "")) { image in
                image.resizable()
            } placeholder: {
                ZStack {
                    Color.gray.opacity(0.1)
                    ProgressView()
                }
            }
            .aspectRatio(contentMode: .fill)
            .frame(height: 120)
            .clipped()
            .cornerRadius(10)
            .padding(.bottom, 4)

            Text(product.name)
                .font(.subheadline).fontWeight(.medium).lineLimit(1)
            
            Text(product.description)
                .font(.caption).foregroundColor(.gray).lineLimit(1)

            HStack {
                Text(product.price).font(.subheadline).fontWeight(.bold)
                Spacer()
                Button(action: {
                    cartManager.addToCart(product: product)
                    // --- CORRECTION 2 ---
                    // The FlyingProduct struct now has a unique 'id' and the 'product' itself.
                    flyingProduct = FlyingProduct(id: UUID(), product: product)
                }) {
                    Text("Add").font(.caption).fontWeight(.semibold)
                        .padding(.horizontal, 15).padding(.vertical, 6)
                        .background(Color.green.opacity(0.15))
                        .foregroundColor(.green).cornerRadius(8)
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
        NavigationView {
            ProductListView(
                products: MockDataSource.products.filter { $0.category == .dairy },
                flyingProduct: .constant(nil)
            )
        }.environmentObject(CartManager())
    }
}
