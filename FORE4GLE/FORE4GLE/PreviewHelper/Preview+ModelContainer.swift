//
//  Preview+ModelContainer.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/2/24.
//

/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An extension that creates a sample model container to use when previewing
 views in Xcode.
*/

import SwiftData

extension ModelContainer {
    static var sample: () throws -> ModelContainer = {
        let schema = Schema([Game.self, Course.self, Score.self, Golfer.self])
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: schema, configurations: [configuration])
        Task { @MainActor in
            Game.insertSampleData(modelContext: container.mainContext)
        }
        return container
    }
}
