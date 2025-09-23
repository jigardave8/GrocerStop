//
//  PromotionCarouselView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//



import SwiftUI

struct PromotionCarouselView: View {
    let promotions: [Promotion]
    
    var body: some View {
        TabView {
            ForEach(promotions) { promo in
                // Remember to add images named "promo1", etc., to your Assets.xcassets
                Image(promo.imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .clipped()
                    .background(Color.gray.opacity(0.1))
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .cornerRadius(10)
    }
}

struct PromotionCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        PromotionCarouselView(promotions: [
            Promotion(imageName: "promo1"),
            Promotion(imageName: "promo2")
        ])
        .frame(height: 180)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
