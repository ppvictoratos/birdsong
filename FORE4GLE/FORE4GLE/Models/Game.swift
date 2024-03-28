//
//  Game.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/29/24.
//

import Foundation
import SwiftData

@Model
final class Game {
    @Attribute(.unique) var stamp: Date
    //var course: Course
    var golfers = [Golfer]()
    var scores = [Score]()
    
    func numGolfers() -> Int {
            return golfers.count
        }
    
    init(stamp: Date, 
         //course: Course,
         golfers: [Golfer],
         scores: [Score]) {
        self.stamp = stamp
        //self.course = course
        self.golfers = golfers
        self.scores = scores
    }
}

extension Game {
    enum weather: String, CaseIterable, Codable {
        case shitty = "Not great conditions, Jim"
        case righty = "Righty' Jimbo!"
    }
}
