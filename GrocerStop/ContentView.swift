//
//  ContentView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//




import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // --- Home Tab ---
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            // --- Cart Tab ---
            CartView()
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
            
            // --- Search Tab (Placeholder) ---
            Text("Search functionality will be built here.")
                .font(.title)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            // --- My Orders Tab (Placeholder) ---
            Text("Past orders will be displayed here.")
                .font(.title)
                .tabItem {
                    Label("Orders", systemImage: "list.bullet")
                }
        }
    }
}

// The original content of ContentView has been moved into its own HomeView
struct HomeView: View {
    @EnvironmentObject var cartManager: CartManager

    // Sample Data - In a real app, this would come from a ViewModel
    let promotions = [
        Promotion(imageName: "promo1"),
        Promotion(imageName: "promo2"),
        Promotion(imageName: "promo3")
    ]
    
    let categories = [
        Category(imageName: "fruits", name: "Fruits"),
        Category(imageName: "vegetables", name: "Vegetables"),
        Category(imageName: "dairy", name: "Dairy"),
        Category(imageName: "meat", name: "Meat"),
        Category(imageName: "bakery", name: "Bakery"),
        Category(imageName: "snacks", name: "Snacks"),
        Category(imageName: "beverages", name: "Beverages"),
        Category(imageName: "frozen", name: "Frozen"),
        Category(imageName: "staples", name: "Staples")
    ]
    
    let products = [
        Product(imageName: "milk", name: "Milk", description: "1L", price: "$2.50"),
        Product(imageName: "bread", name: "White Bread", description: "500g", price: "$3.00"),
        Product(imageName: "eggs", name: "Organic Eggs", description: "12 pack", price: "$5.50"),
        Product(imageName: "butter", name: "Salted Butter", description: "250g", price: "$4.00")
    ]
    
    let snackProducts = [
        Product(imageName: "chips", name: "Potato Chips", description: "Large Pack", price: "$3.75"),
        Product(imageName: "chocolate", name: "Dairy Milk", description: "100g Bar", price: "$2.00"),
        Product(imageName: "juice", name: "Orange Juice", description: "1.5L Bottle", price: "$4.20")
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    HeaderView()
                    SearchBarView()
                    
                    PromotionCarouselView(promotions: promotions)
                        .frame(height: 180)
                        .padding(.vertical, 8)
                    
                    SectionHeaderView(title: "Shop by category")
                    CategoryGridView(categories: categories)
                    
                    SectionHeaderView(title: "Dairy & Bread")
                    ProductListView(products: products)
                        .padding(.bottom)
                    
                    SectionHeaderView(title: "Snacks & Munchies")
                    ProductListView(products: snackProducts)
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(CartManager())
    }
}
