//
//  CollectionModel.swift
//  Pebble
//
//  Created by Vrz on 09/04/26.
//

import SwiftUI
import QuickLookThumbnailing
import LinkPresentation
import SwiftData

@Model
class CollectionModel {
    var id: UUID = UUID()
    var name: String
    var date: Date
    var thumbnail: Data?
    var type: String
    var url: URL?
    
    @Transient
    var uiImage: UIImage? {
        if let data = thumbnail {
            return UIImage(data: data)
        }
        return nil
    }
    
    init(
        name: String,
        date: Date,
        thumbnail: UIImage? = nil,
        type: String,
        url: URL? = nil
    ) {
        self.name = name
        self.date = date
        self.thumbnail = thumbnail?.pngData()
        self.type = type
        self.url = url
    }
}

class CollectionService {
    // Handle File Input
    static func generateFileThumbnail(for url: URL, completion: @escaping (UIImage?) -> Void) {
        let size = CGSize(width: 200, height: 200)
        let request = QLThumbnailGenerator.Request(fileAt: url, size: size, scale: UIScreen.main.scale, representationTypes: .thumbnail)
        QLThumbnailGenerator.shared.generateRepresentations(for: request) { rep, _, _ in
            DispatchQueue.main.async { completion(rep?.uiImage) }
        }
    }
    
    // Handle Link Input
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
