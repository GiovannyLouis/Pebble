//
//  CollectionModel.swift
//  Pebble
//
//  Created by Vrz on 09/04/26.
//

import SwiftUI
import QuickLookThumbnailing
import LinkPresentation

struct CollectionModel: Identifiable {
    let id = UUID()
    let name: String
    let date: Date
    var thumbnail: UIImage?
    var type: CardType
    var url: URL?
    
    enum CardType { case file, link }
}

class CollectionService {
    static func generateFileThumbnail(for url: URL, completion: @escaping (UIImage?) -> Void) {
        let size = CGSize(width: 200, height: 200)
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: UIScreen.main.scale, representationTypes: .thumbnail)
        QLThumbnailGenerator.shared.generateRepresentations(for: request) { rep, _, _ in
            DispatchQueue.main.async { completion(rep?.uiImage) }
        }
    }
    
    static func fetchLinkMetadata(for urlString: String, completion: @escaping (String, UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) { metadata, _ in
            metadata?.imageProvider?.loadObject(ofClass: UIImage.self) { image, _ in
                DispatchQueue.main.async {
                    completion(metadata?.title ?? urlString, image as? UIImage)
                }
            }
        }
    }
}
