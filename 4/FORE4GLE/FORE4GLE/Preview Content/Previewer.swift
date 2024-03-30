//
//  Previewer.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/2/24.
//

import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let game: Game
    let golfer: Golfer
    let strokes: Score

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Golfer.self, configurations: config)

        game = Game(timeStamp: .now)
        golfer = Golfer(id: 01, name: "Los Jeans", tagline: "I'll turn you into denim", handicap: 32, favoriteCourse: "")
        strokes = Score(golfer: golfer, strokes: [1, 2, 3, 4, 3, 2, 4, 5, 2, 3, 4, 2, 3, 4, 2, 3, 1, 4])

        container.mainContext.insert(game)
        container.mainContext.insert(golfer)
        container.mainContext.insert(strokes)
    }
}
