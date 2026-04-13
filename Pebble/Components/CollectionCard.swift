//
//  CollectionCard.swift
//  Pebble
//
//  Created by Vrz on 08/04/26.
//

import SwiftUI

struct CollectionCard: View {
    let collection: CollectionModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Image Section
            Group {
                if let image = collection.uiImage {
                    Image(uiImage: image)
                        .resizable()
                } else {
                    // Fallback for when there's no thumbnail
                    ZStack {
                        Color(red: 0.7, green: 0.75, blue: 0.75)
                        Image(systemName: collection.type == "file" ? "doc.fill" : "link")
                            .foregroundStyle(.white)
                    }
                }
            }
            .scaledToFill()
            .frame(width: 120, height: 80)
            .clipped()
            
            // Text Section
            VStack(alignment: .leading, spacing: 2) {
                Text(collection.name)
                    .font(.system(size: 10))
                    .lineLimit(1)
                    .fontWeight(.bold)
                
                Text(collection.date.formatted(date: .abbreviated, time: .omitted))
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
