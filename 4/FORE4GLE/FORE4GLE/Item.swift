//
//  Item.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/27/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
