//
//  ProductDetailView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import SwiftUI

struct ProductDetailView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    
    let product: Product
    
    @State private var quantity: Int = 1
    @State private var isAddedToCart: Bool = false

    var body: some View {
        // The ScrollView now acts as the base container
        ScrollView {
            // Main VStack to hold all content
            VStack(alignment: .leading, spacing: 0) {
                productImage
                
                // Grouping all text and selectors into a VStack with padding
                VStack(alignment: .leading, spacing: 20) {
                    productTitle
                    Divider()
                    productDescription
                    Divider()
                    quantitySelector
                }
                .padding()
            }
        }
        // Using the standard modifier for the new scroll-edge behavior.
        // It will automatically show a large title when scrolled to the top.
        .navigationTitle(product.name)
        // safeAreaInset places the Add to Cart bar at the bottom, sticky over the content.
        .safeAreaInset(edge: .bottom) {
            addToCartBar
        }
        // Hides the default back button text for a cleaner look
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                 Button {
                    presentationMode.wrappedValue.dismiss()
                 } label: {
                    Image(systemName: "chevron.backward.circle.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                 }
            }
        }
    }
    
    // MARK: - View Components

    private var productImage: some View {
        AsyncImage(url: URL(string: product.imageURL ?? "")) { phase in
            switch phase {
            case .empty:
                ZStack {
                    Color.gray.opacity(0.1)
                    ProgressView()
                }
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            case .failure:
                ZStack {
                    Color.gray.opacity(0.1)
                    Image(systemName: "photo.fill")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: 300)
    }

    private var productTitle: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(product.name)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(product.description)
                .font(.title3)
                .foregroundColor(.gray)
        }
    }

    private var productDescription: some View {
        Text("This is a placeholder for a more detailed product description. It could include nutritional information, sourcing details, or brand story.")
            .font(.body)
            .foregroundColor(.secondary)
    }
    
    private var quantitySelector: some View {
        HStack {
            Text("Quantity")
                .font(.title2)
                .fontWeight(.semibold)
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: { if quantity > 1 { quantity -= 1 } }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                        .foregroundColor(quantity > 1 ? .red : .gray)
                }
                
                Text("\(quantity)")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(minWidth: 40, alignment: .center)
                
                Button(action: { quantity += 1 }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.green)
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
    private var addToCartBar: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Price")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
                Text(product.price)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
            }
            
            Button(action: {
                cartManager.addToCart(product: product, quantity: quantity)
                HapticsManager.shared.impact(style: .heavy)
                
                withAnimation {
                    isAddedToCart = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }) {
                HStack {
                    Image(systemName: isAddedToCart ? "checkmark.circle.fill" : "cart.badge.plus")
                    Text(isAddedToCart ? "Added!" : "Add to Cart")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isAddedToCart ? Color.blue : Color.green)
                .cornerRadius(12)
            }
            .disabled(isAddedToCart)
        }
        .padding()
        .background(.regularMaterial) // This material background looks great when scrolling.
    }
}


struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView(product: MockDataSource.products.first!)
        }
        .environmentObject(CartManager())
    }
}
