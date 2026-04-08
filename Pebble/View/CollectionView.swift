//
//  CollectionView.swift
//  Pebble
//
//  Created by Vrz on 08/04/26.
//

import SwiftUI

struct CollectionView: View {
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(0..<9, id: \.self) { _ in
                        CollectionCard()
                    }
                }
                .padding()
            }
            .navigationTitle("My Collections")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu{
                        Button(action: {}) {
                            Label("File", systemImage: "doc.badge.plus")
                        }
                        
                        Button(action: {}) {
                            Label("Link", systemImage: "link")
                        }
                    } label: {
                        Image(systemName: "plus")
                            .fontWeight(.semibold)
                    }
                }
            }
        }
    }
}

#Preview {
    CollectionView()
}
