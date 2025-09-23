//
//  HeaderView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//




import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "mappin.and.ellipse")
                .font(.title2)
                .foregroundColor(.green)
            VStack(alignment: .leading) {
                Text("Delivery in 12 mins")
                    .font(.headline)
                    .fontWeight(.bold)
                Text("2424 4 St SW, Calgary AB")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Image(systemName: "person.circle")
                .font(.title)
                .foregroundColor(.gray)
        }
        .padding(.top, 10)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
            .previewLayout(.sizeThatFits)
    }
}
