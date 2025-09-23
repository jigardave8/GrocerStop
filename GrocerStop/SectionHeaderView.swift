//
//  SectionHeaderView.swift
//  GrocerStop
//
//  Created by BitDegree on 24/09/25.
//




import SwiftUI

struct SectionHeaderView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .padding(.top, 5)
    }
}

struct SectionHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SectionHeaderView(title: "Example Section")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
