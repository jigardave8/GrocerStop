//
//  OrderSuccessView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import SwiftUI

struct OrderSuccessView: View {
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Order Placed Successfully!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            Text("Your groceries are on the way. You can track your order in the 'My Orders' section.")
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Continue Shopping")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            // When this view appears, the order is complete, so clear the cart.
            cartManager.clearCart()
        }
    }
}

struct OrderSuccessView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSuccessView().environmentObject(CartManager())
    }
}
