//
//  PebbleApp.swift
//  Pebble
//
//  Created by Vrz on 06/04/26.
//

import SwiftUI
import SwiftData

@main
struct PebbleApp: App {
    
    let container: ModelContainer = {
        let schema = Schema(TaskModel.self, CollectionModel.self, SubtaskModel.self)
        let container = try! ModelContainer(for: schema, configurations: [])
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
}
