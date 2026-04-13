//
//  CollectionViewModel.swift
//  Pebble
//
//  Created by Vrz on 08/04/26.
//

import SwiftUI
import SwiftData
import QuickLook

@Observable
class CollectionViewModel {
    // Collections UI State managed by the ViewModel
    var isAddingFile = false
    var isAddingLink = false
    var fileInput = false
    var linkInput = ""
    var selectedFileURL: URL?
    
    // Logic for Links
    func addLink(modelContext: ModelContext) {
        let urlString = linkInput
        let formattedUrl = urlString.lowercased().hasPrefix("http") ? urlString : "https://\(urlString)"
        
        guard let webURL = URL(string: formattedUrl) else { return }
        
        CollectionService.fetchLinkMetadata(for: formattedUrl) { title, image in
            let newCollection = CollectionModel(
                name: title,
                date: Date(),
                thumbnail: image,
                type: "link",
                url: webURL
            )
            modelContext.insert(newCollection)
            try? modelContext.save()
        }
        // Reset input
        linkInput = ""
        isAddingLink = false
    }

    // Logic for Files
    func addFile(from url: URL, modelContext: ModelContext) {
        if url.startAccessingSecurityScopedResource() {
            CollectionService.generateFileThumbnail(for: url) { thumb in
                let newCollection = CollectionModel(
                    name: url.lastPathComponent,
                    date: Date(),
                    thumbnail: thumb,
                    type: "file",
                    url: url
                )
                modelContext.insert(newCollection)
                try? modelContext.save()
                url.stopAccessingSecurityScopedResource()
            }
        }
    }

    // Logic for Tapping
    func handleTap(for collection: CollectionModel) {
        guard let targetURL = collection.url else { return }
        
        if collection.type == "link" {
            UIApplication.shared.open(targetURL)
        } else {
            self.selectedFileURL = targetURL
        }
    }
}
