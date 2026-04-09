//
//  CollectionModel.swift
//  Pebble
//
//  Created by Stefanie Agahari on 07/04/26.
//

import Foundation
import SwiftData

@Model
class CollectionModel {
    var link: String?
    
    @Attribute(.externalStorage) // kalau size file nya lebih nnt bakal di save di external storage nya iOS (SQLite)
    var files: Data?
    
    init(link: String? = nil, files: Data? = nil) {
        self.link = link
        self.files = files
    }
}
