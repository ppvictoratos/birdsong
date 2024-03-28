//
//  SampleData+Scores.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/2/24.
//

import Foundation
import SwiftData

extension Game {
    static let game1 = Game(stamp: .now, course: Course.alleypond, golfers: [.hennur, .snoop], scores: [.good, .good])
    
//    static let game2 = Game(timeStamp: .distantPast,
//                            course: Course.eisenhower,
//                            golfers: [.pete],
//                            scores: [.good, .shitty])
//    
//    static let game3 = Game(timeStamp: .distantFuture,
//                            course: Course.flushing,
//                            golfers: [.hennur, .snoop, .pete, .anon],
//                            scores: [.good, .good, .good, .good])
//    
//    static let game4 = Game(timeStamp: .now,
//                            course: Course.monster,
//                            golfers: [.pete, .snoop],
//                            scores: [.shitty, .shitty])
    
    static func insertSampleData(modelContext: ModelContext) {
        modelContext.insert(game1)
//        modelContext.insert(game2)
//        modelContext.insert(game3)
//        modelContext.insert(game4)
        
        modelContext.insert(Course.alleypond)
//        modelContext.insert(Course.eisenhower)
//        modelContext.insert(Course.flushing)
//        modelContext.insert(Course.monster)
        
        modelContext.insert(Golfer.anon)
//        modelContext.insert(Golfer.pete)
//        modelContext.insert(Golfer.hennur)
//        modelContext.insert(Golfer.snoop)
//        
        Game.game1.golfers = game1.golfers
        Game.game1.scores = game1.scores
        Game.game1.stamp = game1.stamp
        Game.game1.course = game1.course
    }
    
    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Game.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
