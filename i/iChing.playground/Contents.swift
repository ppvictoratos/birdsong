//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import UIKit
import XCTest
import Foundation
import PlaygroundSupport

struct Hexagram {
    var id: Int
    var title: String
    var hanzi: String
    var passage: String
}

let sampleData: [Hexagram] = [
    Hexagram(id: 15,
             title: "Modesty",
             hanzi: "謙",
             passage: "The Creative acts to empty what is full and to offer abundance to what is modest."),
    Hexagram(id: 27,
             title: "Corners of the Mouth",
             hanzi: "頤",
             passage: "How you nourish your body is no different from how you are organizing your experiences.")
]

struct HexagramCard: View {
    var hexagram: Hexagram
    
    //todo: make this into a card
    var body: some View {
        Text(hexagram.title)
    }
}

let hostingVC = UIHostingController(rootView: HexagramCard(hexagram: sampleData[1]))
PlaygroundPage.current.liveView = hostingVC


//what kind of tests can i have?
