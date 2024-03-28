//
//  Golfer.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/27/24.
//

import Foundation
import SwiftData

@Model
final class Golfer {
    var name: String
    var tagline: String
    var favoriteCourse: String

    init(name: String, tagline: String, favoriteCourse: String) {
        self.name = name
        self.tagline = tagline
        self.favoriteCourse = favoriteCourse
    }
}
