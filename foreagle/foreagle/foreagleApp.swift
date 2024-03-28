//
//  foreagleApp.swift
//  foreagle
//
//  Created by Petie Positivo on 1/24/24.
//

import SwiftUI
import SwiftData

@main
struct foreagleApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Game.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
