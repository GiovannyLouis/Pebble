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
    
//    gateway into using a container outside of the view
//    let container: ModelContainer = {
//        let schema = Schema([TaskModel.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
            HomepageView()
        }
//        .modelContainer(container)
        .modelContainer(for: TaskModel.self)
    }
}
