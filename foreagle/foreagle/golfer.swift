//
//  golfer.swift
//  foreagle
//
//  Created by Petie Positivo on 1/24/24.
//

import SwiftData

@Model
class Golfer: Hashable {
    var id: Int8
    var name: String
    var tagline: String
    
    init(id: Int8, name: String, tagline: String) {
        self.id = id
        self.name = name
        self.tagline = tagline
    }
}
