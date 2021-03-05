//
//  Trash_ItApp.swift
//  Trash It
//
//  Created by Peter Victoratos on 2/18/21.
//

import SwiftUI

@main
struct Trash_ItApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentContainer.viewContext)
        }
    }
}
