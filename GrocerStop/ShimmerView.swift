//
//  ShimmerView.swift
//  GrocerStop
//
//  Created by BitDegree on 08/10/25.
//




import SwiftUI

struct ShimmerView: View {
    @State private var phase: CGFloat = -1.0
    private let duration: Double = 1.5

    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.3))
            .modifier(ShimmerEffect(phase: phase))
            // --- CORRECTION ---
            // The '.animation' modifier is now correctly applied.
            // The `value` parameter tells SwiftUI to only animate when the `phase` state changes.
            .animation(.linear(duration: duration).repeatForever(autoreverses: false), value: phase)
            .onAppear {
                // We wrap the state change in `withAnimation` to trigger the initial animation.
                withAnimation {
                    phase = 1.0
                }
            }
    }
}

struct ShimmerEffect: ViewModifier {
    var phase: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .clear, location: max(0, phase - 0.4)),
                        .init(color: Color.white.opacity(0.5), location: phase),
                        .init(color: .clear, location: min(1, phase + 0.4))
                    ]),
                    startPoint: .topLeading, endPoint: .bottomTrailing
                )
            )
    }
}
