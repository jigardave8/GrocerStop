//
//  OnboardingView.swift
//  GrocerStop
//
//  Created by BitDegree on 08/10/25.
//


import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "basket.fill").font(.system(size: 100)).foregroundColor(.green).padding()
            Text("Welcome to GrocerStop").font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center)
            Text("Fresh groceries delivered to your door in minutes.").font(.headline).foregroundColor(.gray).multilineTextAlignment(.center).padding(.horizontal, 40)
            Spacer()
            Button(action: {
                withAnimation {
                    AppStorageManager.hasCompletedOnboarding = true
                }
            }) {
                Text("Get Started").font(.headline).fontWeight(.semibold).foregroundColor(.white).padding().frame(maxWidth: .infinity).background(Color.green).cornerRadius(12)
            }
            .padding(.horizontal, 30).padding(.bottom, 50)
        }
    }
}
