//
//  CartView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//


import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var isShowingOrderSuccess = false

    var body: some View {
        NavigationView {
            VStack {
                if cartManager.items.isEmpty {
                    Spacer()
                    Image(systemName: "cart.badge.questionmark")
                        .font(.system(size: 80))
                        .foregroundColor(.gray.opacity(0.5))
                    Text("Your cart is empty.")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .padding(.top)
                    Spacer()
                } else {
                    List {
                        ForEach(cartManager.items) { product in
                            HStack {
                                Image(product.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8)

                                VStack(alignment: .leading) {
                                    Text(product.name)
                                        .font(.headline)
                                    Text(product.price)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                                Spacer()
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(PlainListStyle()) // More modern list style
                    
                    // --- Checkout Section ---
                    VStack(spacing: 12) {
                        HStack {
                            Text("Total:")
                                .font(.headline)
                                .foregroundColor(.gray)
                            Spacer()
                            Text(String(format: "$%.2f", cartManager.total))
                                .font(.title2)
                                .fontWeight(.bold)
                        }

                        // This link is triggered by the button's state change
                        NavigationLink(destination: OrderSuccessView(), isActive: $isShowingOrderSuccess) { EmptyView() }
                        
                        Button(action: {
                            isShowingOrderSuccess = true
                        }) {
                            Text("Place Order")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                    }
                    .padding()
                    .background(Color(.systemGray6))
                }
            }
            .navigationTitle("My Cart")
            .navigationBarItems(trailing: EditButton()) // Allows easier deletion from the list
        }
    }

    private func deleteItems(at offsets: IndexSet) {
        // First, get the product to remove
        if let index = offsets.first {
            let product = cartManager.items[index]
            // Then, call the remove function
            cartManager.removeFromCart(product: product)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a dummy CartManager and add an item for a realistic preview
        let cartManager = CartManager()
        cartManager.addToCart(product: Product(imageName: "milk", name: "Preview Milk", description: "1L", price: "$2.99"))
        
        return CartView().environmentObject(cartManager)
    }
}
