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
            // Main content of the view is a VStack that contains either
            // the empty view or the list + checkout section.
            VStack {
                if cartManager.items.isEmpty {
                    emptyCartView
                } else {
                    cartListView
                }
            }
            .navigationTitle("My Cart")
            // Hide the edit button if the cart is empty
            .navigationBarItems(trailing: cartManager.items.isEmpty ? nil : EditButton())
        }
    }

    // This view contains the list of cart items
    private var cartListView: some View {
        // We use a VStack to combine the List and the checkout section
        VStack(spacing: 0) {
            List {
                ForEach(cartManager.items) { item in
                    CartItemRow(item: item)
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            
            checkoutSection
        }
    }
    
    // A separate struct for the row improves performance and organization
    struct CartItemRow: View {
        @EnvironmentObject var cartManager: CartManager
        let item: CartItem
        
        var body: some View {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: item.product.imageURL ?? "")) { image in image.resizable() } placeholder: {
                    ProgressView()
                }
                .scaledToFit()
                .frame(width: 50, height: 50)
                .cornerRadius(8)
                .background(Color.gray.opacity(0.1))
                
                VStack(alignment: .leading) {
                    Text(item.product.name).font(.headline)
                    Text(item.product.price).font(.subheadline).foregroundColor(.gray)
                }
                Spacer()
                HStack(spacing: 12) {
                    Button(action: { cartManager.decrementQuantity(for: item) }) {
                        Image(systemName: "minus.circle").font(.title2).foregroundColor(.red)
                    }
                    Text("\(item.quantity)").font(.headline).frame(minWidth: 25, alignment: .center)
                    Button(action: { cartManager.incrementQuantity(for: item) }) {
                        Image(systemName: "plus.circle").font(.title2).foregroundColor(.green)
                    }
                }.buttonStyle(PlainButtonStyle())
            }.padding(.vertical, 8)
        }
    }

    // The new, enhanced empty cart view
    private var emptyCartView: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "cart").font(.system(size: 80)).foregroundColor(.gray.opacity(0.5))
            Text("Your cart is empty").font(.title2).fontWeight(.bold)
            Text("Looks like you haven't added anything yet. Start browsing to find your favorites!").font(.subheadline).foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal, 40)
            Text("Tap the 'Home' tab to start shopping.").font(.headline).foregroundColor(.green).padding(.top)
            Spacer()
        }
    }
    
    private var checkoutSection: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Total:").font(.headline).foregroundColor(.gray)
                Spacer()
                Text(String(format: "$%.2f", cartManager.total)).font(.title2).fontWeight(.bold)
            }
            NavigationLink(destination: OrderSuccessView(), isActive: $isShowingOrderSuccess) { EmptyView() }
            Button("Place Order") { isShowingOrderSuccess = true }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity).padding().background(Color.green).cornerRadius(12)
        }.padding().background(Color(.systemGray6))
    }
    
    private func deleteItems(at offsets: IndexSet) {
        if let index = offsets.first {
            let item = cartManager.items[index]
            cartManager.removeItem(for: item)
        }
    }
}
