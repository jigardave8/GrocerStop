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
                NavigationLink(destination:
                    CategoryDetailView(
                        category: Category(imageName: "", name: promo.destinationCategory),
                        allProducts: MockDataSource.products
                    )
                ) {
                    Image(promo.imageName).resizable().aspectRatio(contentMode: .fill).frame(maxWidth: .infinity).clipped().background(Color.gray.opacity(0.1))
                }
            }
        }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic)).cornerRadius(10)
    }
}
