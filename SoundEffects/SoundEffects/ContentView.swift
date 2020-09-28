//
//  ContentView.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/23/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        PlayerView()
    }
}

struct PlayerView: View {
    @State private var songLength: Double = 0
    
    var body: some View {
        VStack {
            Spacer(minLength: 75)
            Image(systemName: "tuningfork").foregroundColor(.white).font(.system(size: 90)).padding()
            HStack {
                Spacer(minLength: 45)
                Slider(value: $songLength, in: 0...100, step: 1).padding()
                Spacer(minLength: 45)
                
                //radix 2 means that the terms within it needs to be divisble by two (like have enough terms to be split, ie: more than one) BFP conforms to this
            }
            Spacer()
            HStack {
                Text("Song Metadata").foregroundColor(.white).padding()
            }
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    //rewind song 15 seconds
                        //would be cool to make this dynamic
                }) {
                    Image(systemName: "gobackward.15").foregroundColor(.orange).font(.system(size: 40))
                }
                Spacer()
                Button(action: {
                    //Play / Pause song
                }) {
                    Image(systemName: "play.circle.fill").foregroundColor(.orange).font(.system(size: 40))
                }
                Spacer()
                Button(action: {
                    //fast forward song 15 seconds
                        //would be cool to make this dynamic
                }) {
                    Image(systemName: "goforward.15").foregroundColor(.orange).font(.system(size: 40))
                }
                Spacer()
            }
            //would be great to have some kinda visual divider here
            
            VStack {
                Spacer()
                Button(action: {
                    //increase gain
                }) {
                    Image(systemName: "moon").font(.system(size: 60))
                }
                Spacer()
                Button(action: {
                    //reverb
                }) {
                    Image(systemName: "radiowaves.right").font(.system(size: 60))
                }
                Spacer()
                Button(action: {
                    //fun effect
                }) {
                    Image(systemName: "hammer").font(.system(size: 60))
                }
                Spacer()
            }
        }.background(Color.init(.darkGray))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
