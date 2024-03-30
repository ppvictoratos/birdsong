//
//  SampleData+Golfers.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/2/24.
//

import Foundation
import SwiftData

extension Golfer {
    static let anon = Golfer(name: "Anon", 
                             tagline: "Every stroke counts",
                             favoriteCourse: Course.alleypond.name)

    static let pete = Golfer(name: "Peter Panagiotis Victoratos",
                             tagline: "I'll turn you into denim",
                             favoriteCourse: Course.eisenhower.name)
    
    static let hennur = Golfer(name: "Dr. Sinks", 
                               tagline: "I'm tired",
                               favoriteCourse: Course.flushing.name)
    
    static let snoop = Golfer(name: "Snarp", 
                              tagline: "`Woof` *hits the deck*",
                              favoriteCourse: Course.monster.name)
}
