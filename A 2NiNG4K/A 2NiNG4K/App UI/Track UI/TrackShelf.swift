//
//  TrackShelf.swift
//  A 2NiNG4K
//
//  Created by Peter Victoratos on 10/26/20.
//

import SwiftUI

struct TrackShelf: View {
    var body: some View {
        Shelf()
    }
}

struct TrackCardBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .center) {
            configuration.label
            configuration.content
        }.padding()
        .background(randomEarthTone())
        .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
        .font(.footnote)
        .offset(x: 0, y: 265.0)
        
        //i need to fit the body into a shelf (scroll view)
        //or for now, how do I shrink the space in between?
    }
    
    //make these only earth tones, how can i generate "random" colors that fall into a certain range?
    func randomEarthTone() -> Color { return Color("Earth1") }
}

//this needs to animate down on a tap
//should be accent color
struct Shelf: View {
    var body: some View {
            trackCards()
    }
}

struct trackCards: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(0..<14) { _ in
                    GroupBox(
                        label: Label("Title", systemImage: "music.note")
                            .foregroundColor(.white)
                    ) {
                        Text("03:24")
                    }.groupBoxStyle(TrackCardBoxStyle())
                }
            }.padding()
            .frame(width: 210.0, height: 180, alignment: .center)
            
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TrackShelf_Previews: PreviewProvider {
    static var previews: some View {
        TrackShelf()
    }
}

//seems I can use the GroupBoxStyle protocol for now. i'd like to make it a witness

