//
//  AccountView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import SwiftUI

struct AccountView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Account Details")) {
                    HStack {
                        Image(systemName: "person.circle.fill")
                        Text("Profile")
                    }
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                        Text("Saved Addresses")
                    }
                    HStack {
                        Image(systemName: "creditcard.fill")
                        Text("Payment Methods")
                    }
                }

                Section(header: Text("App Settings")) {
                    HStack {
                        Image(systemName: "bell.fill")
                        Text("Notifications")
                    }
                    HStack {
                        Image(systemName: "questionmark.circle.fill")
                        Text("Help & Support")
                    }
                }
                
                Section {
                    Button("Log Out", role: .destructive) {
                        // Log out action goes here
                        print("User logged out.")
                    }
                }
            }
            .navigationTitle("My Account")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
