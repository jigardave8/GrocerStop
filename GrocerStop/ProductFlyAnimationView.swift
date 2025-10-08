//
//  ProductFlyAnimationView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//


import SwiftUI

struct ProductFlyAnimationView: View {
    let product: Product
    let endPosition: CGPoint
    let onAnimationFinished: () -> Void
    
    @State private var startPosition: CGPoint = .zero
    @State private var currentPosition: CGPoint = .zero
    @State private var size: CGSize = CGSize(width: 80, height: 80)
    @State private var opacity: Double = 1.0
    
    var body: some View {
        // We need the product's image for the animation. Using AsyncImage.
        AsyncImage(url: URL(string: product.imageURL ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            // If the image hasn't loaded, use a system image
            Image(systemName: "photo.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray.opacity(0.3))
        }
        .frame(width: size.width, height: size.height)
        .position(currentPosition)
        .opacity(opacity)
        .background(
            // Capture the initial position of the view itself
            GeometryReader { geo in
                Color.clear.onAppear {
                    // --- CORRECTION ---
                    // Calculate the center point using midX and midY instead of the .center property.
                    let frame = geo.frame(in: .global)
                    let centerPoint = CGPoint(x: frame.midX, y: frame.midY)
                    
                    self.startPosition = centerPoint
                    self.currentPosition = centerPoint
                    performAnimation()
                }
            }
        )
    }
    
    private func performAnimation() {
        // Use a single animation block for a smoother effect
        withAnimation(.easeInOut(duration: 0.7)) {
            currentPosition = endPosition
            size = CGSize(width: 20, height: 20) // Shrink the image as it flies
            opacity = 0.5
        }
        
        // Use a dispatch queue to signal when the animation is likely finished
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeInOut(duration: 0.2)) {
                opacity = 0 // Fully fade out at the end
            }
            // A short delay before calling the completion handler to ensure fade-out is complete
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                 onAnimationFinished()
            }
        }
    }
}
