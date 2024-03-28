//
//  A2NiNG4KApp.swift
//  A2NiNG4K
//
//  Created by Petie Positivo on 4/18/22.
//

import SwiftUI

@main
struct A2NiNG4KApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
