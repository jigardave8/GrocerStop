//
//  HomeSkeletonView.swift
//  GrocerStop
//
//  Created by BitDegree on 08/10/25.
//


import SwiftUI

struct HomeSkeletonView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ShimmerView().frame(height: 180).cornerRadius(10).padding(.vertical, 8)
                ShimmerView().frame(width: 200, height: 24).cornerRadius(5)
                HStack(spacing: 20) {
                    ForEach(0..<4) { _ in
                        VStack {
                            ShimmerView().frame(width: 70, height: 70).cornerRadius(10)
                            ShimmerView().frame(width: 50, height: 10).cornerRadius(5)
                        }
                    }
                }
                ShimmerView().frame(width: 180, height: 24).cornerRadius(5).padding(.top)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(0..<3) { _ in ProductCardSkeletonView() }
                    }
                }
                .padding(.bottom)
            }.padding()
        }.disabled(true)
    }
}

struct ProductCardSkeletonView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ShimmerView().frame(height: 120).cornerRadius(10).padding(.bottom, 4)
            ShimmerView().frame(height: 14).cornerRadius(5)
            ShimmerView().frame(width: 100, height: 10).cornerRadius(5)
            HStack {
                ShimmerView().frame(width: 50, height: 16).cornerRadius(5)
                Spacer()
                ShimmerView().frame(width: 60, height: 30).cornerRadius(8)
            }
        }
        .frame(width: 150).padding(10).background(Color.white).cornerRadius(15).shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
