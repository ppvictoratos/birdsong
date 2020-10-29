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
        .offset(x: 0, y: 135.0)
    }
    
    //make these only earth tones
    func randomEarthTone() -> Color { return Color("Earth1") }
}

//this needs to animate down on a tap
//should be accent color
struct Shelf: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .accentColor(.accentColor)
                .frame(width: 150, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            trackCard()
        }
    }
}

struct trackCard: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [.init(), .init()]) {
                ForEach(0..<8) { _ in
                    GroupBox(
                        label: Label("Title", systemImage: "music.note")
                            .foregroundColor(.white)
                    ) {
                        Text("03:24")
                    }.groupBoxStyle(TrackCardBoxStyle())
                }
            }.padding()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct TrackShelf_Previews: PreviewProvider {
    static var previews: some View {
        TrackShelf()
            .preferredColorScheme(.dark)
    }
}

//seems I can use the GroupBoxStyle protocol for now. i'd like to make it a witness

