//
//  CollectionCard.swift
//  Pebble
//
//  Created by Vrz on 08/04/26.
//

import SwiftUI

struct CollectionCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("img1")
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 80)
            VStack(alignment: .leading, spacing: 2) {
                Text("Design Process Journey")
                    .font(.system(size: 10))
                    .lineLimit(1)
                    .fontWeight(.bold)
                Text("8 Apr 2026")
                    .font(.system(size: 8))
                    .foregroundStyle(Color(red: 0.3, green: 0.3, blue: 0.3))
                    .lineLimit(1)
            }
            .padding(.horizontal, 4)
            Spacer()
        }
        .background(Color(red: 0.8, green: 0.85, blue: 0.85))
        .frame(width: 120, height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
    }
}

#Preview {
    CollectionCard()
}
