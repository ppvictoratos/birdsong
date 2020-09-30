//
//  ContentView.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/23/20.
//

import SwiftUI
import CoreAudioKit
import AVFoundation


struct ContentView: View {
    var body: some View {
        PlayerView()
        //make the whole thing grey
    }
}

struct PlayerView: View {
    @State private var songLength: Double = 0

    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Image(systemName: "tuningfork").foregroundColor(.black).font(.system(size: 90)).padding().offset(x: -2.5, y:0)
                    Image(systemName: "tuningfork").foregroundColor(Color("hotpink")).font(.system(size: 90)).padding().offset(x:2.5,y:0)
                }
                HStack {
                    Spacer(minLength: 45)
                    Slider(value: $songLength, in: 0...100, step: 1).padding()
                    Spacer(minLength: 45)
                    
                    //radix 2 means that the terms within it needs to be divisble by two (like have enough terms to be split, ie: more than one) BFP conforms to this
                }
                HStack {
                    Text("Sample Song Metadata").foregroundColor(.black).padding().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                
                TimeControls().padding(.all, 30)
                    .padding(.bottom, 60)
                //would be great to have some kinda visual divider here
                
                VStack {
                    Button(action: {
                        //increase gain
                    }) {
                        Image(systemName: "capslock").font(.system(size: 60)).padding(10).foregroundColor(Color("hotpink"))
                    }
                    Button(action: {
                        //reverb
                    }) {
                        Image(systemName: "r.circle").font(.system(size: 60)).padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(Color("hotpink"))
                    }
                    Button(action: {
                        //fun effect
                    }) {
                        Image(systemName: "wand.and.rays").font(.system(size: 60)).padding(10).foregroundColor(Color("hotpink"))
                    }
                }
            }
        }
        
    }
}

struct TimeControls: View {
    var body: some View {
        HStack {
            Button(action: {
                //rewind song 15 seconds
                //would be cool to make this dynamic
            }) {
                Image(systemName: "gobackward.15").foregroundColor(Color("MainColor")).font(.system(size: 60))
            }.padding(.trailing, 15)
            Button(action: {
                //Play / Pause song
            }) {
                Image(systemName: "play.circle.fill").foregroundColor(Color("hotpink")).font(.system(size: 60))
            }.padding(.trailing, 15)
            Button(action: {
                //fast forward song 15 seconds
                //would be cool to make this dynamic
            }) {
                Image(systemName: "goforward.15").foregroundColor(Color("MainColor")).font(.system(size: 60))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
