//
//  SampleData+Scores.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/3/24.
//

import Foundation
import SwiftData

extension Score {
    static let good = Score(id: 01, strokes: [3, 3, 4, 4, 3, 4, 4, 3, 4, 3, 4, 3, 3, 4, 3, 4, 4, 3])
    static let decent = Score(id: 02, strokes: [4, 4, 5, 4, 4, 5, 5, 4, 5, 4, 5, 4, 4, 5, 4, 5, 5, 4])
    static let bad = Score(id: 03, strokes: [5, 5, 6, 5, 5, 6, 6, 5, 6, 5, 6, 5, 5, 6, 5, 6, 6, 5])
    static let shitty = Score(id: 04, strokes: [6, 6, 7, 6, 6, 7, 7, 6, 7, 6, 7, 6, 6, 7, 6, 7, 7, 6])
}
