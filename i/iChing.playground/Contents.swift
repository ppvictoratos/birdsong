import SwiftUI
import XCTest
import Foundation
import PlaygroundSupport


struct Hexagram {
    var id: Int
    var title: String
    var hanzi: String
    var passage: String
    var hexagram: String
}

let sampleData: [Hexagram] = [
    Hexagram(id: 15,
             title: "Modesty",
             hanzi: "謙",
             passage: "The Creative acts to empty what is full and to offer abundance to what is modest.",
             hexagram: "䷎"),
    Hexagram(id: 27,
             title: "Corners of the Mouth",
             hanzi: "頤",
             passage: "How you nourish your body is no different from how you are organizing your experiences.",
             hexagram: "䷚")
]

struct HexagramCard: View {
    var hexagram: Hexagram
    
    var body: some View {
        ZStack{
            Color(red: 0.8, green: 0.7, blue: 0.4)
            Text(hexagram.hexagram)
                .font(.system(size: 175))
                .opacity(0.1)
            VStack{
                Text(hexagram.hanzi)
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.bar)
                Text(hexagram.title)
                    .bold()
                Text(hexagram.passage)
                    .font(.footnote)
                    .bold()
                    .multilineTextAlignment(.center)
            }
        }.frame(width: 150, height: 200)
    }
}

///PREVIEWS
///
//Hexagram Card
let testHex = HexagramCard(hexagram: sampleData[1])
PlaygroundPage.current.setLiveView(testHex)
