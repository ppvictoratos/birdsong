//
//  Score.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/31/24.
//

import Foundation
import SwiftData

@Model
final class Score {
    @Attribute(.unique) var id: Int
    var strokes: [Int] = Array(repeating: 0, count: 18)
    
    init(id: Int, strokes: [Int] = [Int]()) {
        self.id = id
        self.strokes = strokes
    }
    
}
