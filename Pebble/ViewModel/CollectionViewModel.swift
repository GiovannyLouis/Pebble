//
//  CollectionViewModel.swift
//  Pebble
//
//  Created by Stefanie Agahari on 09/04/26.
//

import Foundation
import SwiftData
import Observation

enum CollectionError: LocalizedError {
    case fileTooLarge
    
    var errorDescription: String? {
        switch self {
        case .fileTooLarge:
            return "File size is too big! Maximum size is 10 MB."
        }
    }
}

@Observable
class CollectionViewModel {
    var modelContext: ModelContext // untuk mengakses database SwiftData
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func addLink(link: String) {
          let newCollection = CollectionModel(link: link, files: nil)
          modelContext.insert(newCollection)
    }
        
    func addFile(files: Data) throws {
            // hitung limit 10 MB dalam bentuk bytes
            let limitInBytes = 10 * 1024 * 1024 // 10.485.760 bytes
            
            if files.count > limitInBytes {
                throw CollectionError.fileTooLarge
            }
            
            let newCollection = CollectionModel(link: nil, files: files)
            modelContext.insert(newCollection)
   }
}
