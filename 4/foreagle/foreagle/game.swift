//
//  game.swift
//  foreagle
//
//  Created by Petie Positivo on 1/24/24.
//

import SwiftData
import Foundation

let sampleScore = [2, 3, 3, 4, 2, 5, 1, 2, 3, 3, 2, 3, 4, 3, 2, 2, 3, 4]
let sampleGolfer = Golfer(id: 0, name: "Anon", tagline: "Every Stroke Counts")

@Model
final class Game {
    @Attribute(.unique) var timestamp: Date
    
    var golferScore: [Int: [Int]]
    
    init(timestamp: Date, golferScore: [Int: [Int]]) {
        self.timestamp = timestamp
        self.golferScore = golferScore


    }
    
    func scoreToText(index: Int, score: [Int: [Int]]) -> String {
        return sampleGolfer.name + "'s score is :" + String(sampleScore.first == 2 ? String(2) : "hey")
    }
}
