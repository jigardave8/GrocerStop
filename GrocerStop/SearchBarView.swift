//
//  SearchBarView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//


import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String // Now a binding to share the state

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search for products", text: $searchText)
            
            // Add a clear button that appears when text is present
            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(10)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        // Use .constant for previewing a binding
        SearchBarView(searchText: .constant("Milk"))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
