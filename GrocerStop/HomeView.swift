//
//  HomeView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @Binding var flyingProduct: FlyingProduct?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HeaderView().padding(.horizontal)
                SearchBarView(searchText: $viewModel.searchText).padding()
                switch viewModel.state {
                case .loading:
                    HomeSkeletonView()
                case .success(let allProducts):
                    contentView(allProducts: allProducts)
                case .error(let errorMessage):
                    errorView(message: errorMessage)
                }
            }
            .navigationBarHidden(true)
        }
        .task {
            // Load products only if they haven't been loaded yet.
            if case .loading = viewModel.state {
                 await viewModel.loadProducts()
            }
        }
    }

    @ViewBuilder
    private func contentView(allProducts: [Product]) -> some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0, pinnedViews: .sectionHeaders) {
                Section {
                    VStack(alignment: .leading, spacing: 16) {
                        PromotionCarouselView(promotions: viewModel.promotions)
                            .frame(height: 180).padding(.bottom, 8)
                        SectionHeaderView(title: "Shop by category")
                        
                        // --- CORRECTION ---
                        // Added the missing 'allProducts' parameter.
                        CategoryGridView(categories: viewModel.categories, allProducts: allProducts)
                        
                    }.padding(.horizontal)
                }
                
                // Show search results if searching, otherwise show curated sections
                if viewModel.isSearching {
                    if viewModel.searchResults.isEmpty {
                         Text("No results found for '\(viewModel.searchText)'")
                            .foregroundColor(.gray).padding().frame(maxWidth: .infinity, alignment: .center)
                    } else {
                        // Display search results as a single list
                        Section(header: SectionHeaderView(title: "Search Results").padding(.horizontal)) {
                            ProductListView(products: viewModel.searchResults, flyingProduct: $flyingProduct)
                                .padding(.vertical, 10)
                        }
                    }
                } else {
                    // Curated sections are only shown when not searching
                    if !viewModel.featuredProducts.isEmpty {
                        Section(header: SectionHeaderView(title: "Featured Products").padding(.horizontal)) {
                            ProductListView(products: viewModel.featuredProducts, flyingProduct: $flyingProduct)
                                .padding(.vertical, 10)
                        }
                    }
                    if !viewModel.dairyProducts.isEmpty {
                        Section(header: SectionHeaderView(title: "Dairy & Bread").padding(.horizontal)) {
                            ProductListView(products: viewModel.dairyProducts, flyingProduct: $flyingProduct)
                                .padding(.vertical, 10)
                        }
                    }
                    if !viewModel.snackProducts.isEmpty {
                        Section(header: SectionHeaderView(title: "Snacks & Munchies").padding(.horizontal)) {
                            ProductListView(products: viewModel.snackProducts, flyingProduct: $flyingProduct)
                                .padding(.vertical, 10)
                        }
                    }
                }
            }
        }
        .refreshable { await viewModel.loadProducts() }
    }
    
    @ViewBuilder
    private func errorView(message: String) -> some View {
        VStack(spacing: 10) {
            Spacer()
            Image(systemName: "wifi.exclamationmark").font(.largeTitle).foregroundColor(.red)
            Text("Failed to load groceries").font(.headline).padding(.top)
            Text(message).font(.footnote).foregroundColor(.gray)
            Button("Try Again") {
                Task { await viewModel.loadProducts() }
            }.padding(.top).buttonStyle(.bordered)
            Spacer()
        }
    }
}
