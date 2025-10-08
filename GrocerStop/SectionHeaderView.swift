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
            .font(.title2).fontWeight(.bold).padding(.vertical, 8)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(.background)
    }
}
