//
//  ContentView.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/23/20.
//

import SwiftUI
import CoreAudioKit
import AVFoundation
var player: AVAudioPlayer!
var audioUnit: AudioUnit!

struct ContentView: View {
    var body: some View {
        PlayerView()
    }
}

struct PlayerView: View {
    
    var body: some View {
        ZStack {
            VStack {
                SELogo()
                
                HStack {
                    Spacer(minLength: 45)
                    TrackView()
                    Spacer(minLength: 45)
                }
                
                HStack {
                    Text("Song Metadata").foregroundColor(Color("KW")).padding().font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                }
                
                AudioTimeControls().padding(.all, 30)
                    .padding(.bottom, 35)
                
                EffectControls()
            }
        }
        
    }
}

// MARK: - TOP HALF

struct SELogo: View {
    
    var body: some View {
        ZStack {
            Image(systemName: "tuningfork").foregroundColor(Color("KW")).font(.system(size: 90)).padding().offset(x: -2.5, y:0)
            Image(systemName: "tuningfork").foregroundColor(Color("hotpink")).font(.system(size: 90)).padding().offset(x:2.5,y:0)
        }
    }
}

struct TrackView: View {
    var body: some View {
        Text(" ")
            .font(.largeTitle)
            .frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .background(Color.init("MainColor"))
    }
}

struct AudioWaves: View {
    var amplitude: CGFloat
    
    var body: some View {
        //foreach?
        Rectangle().frame(maxHeight: amplitude)
    }
}


// MARK: - AUDIO CONTROLS
struct AudioTimeControls: View {
    
    var body: some View {
        HStack {
            Button(action: {
                player.currentTime -= TimeInterval(10)
            }) {
                Image(systemName: "gobackward.10").foregroundColor(Color("MainColor")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            Button(action: {
                    //Play / Pause song
                    playLocalSound(sound: "JACKBOYS", type: "mp3")
            }) {
                //add state to pause
                //pause.circle.fill
                Image(systemName: "play.circle.fill").foregroundColor(Color("hotpink")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            Button(action: {
                //fast forward song 15 seconds
                player.currentTime += TimeInterval(10)
            }) {
                Image(systemName: "goforward.10").foregroundColor(Color("MainColor")).font(.system(size: 60))
            }
        }
    }
}

// MARK: - AUDIO EFFECTS

struct EffectControls: View {
    
    var body: some View {
        VStack {
            //OVERKILL UNDO
            Button(action: {
                player.setVolume(5.0, fadeDuration: TimeInterval(3))
            }) {
                Image(systemName: "arrow.uturn.left.square").font(.system(size: 60)).padding(10).foregroundColor(Color("KW"))
            }
            //INCREASE GAIN STATICLY
            Button(action: {
                player.setVolume(20.0, fadeDuration: TimeInterval(3))
            }) {
                Image(systemName: "capslock").font(.system(size: 60)).padding(10).foregroundColor(Color("hotpink"))
            }
            //INCREASE REVERB STATICALLY
            Button(action: {
                //reverb
                
            }) {
                Image(systemName: "r.circle").font(.system(size: 60)).padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(Color("hotpink"))
            }
            //DOES SOMETHING FUN
            Button(action: {
                //fun effect
            }) {
                Image(systemName: "wand.and.rays").font(.system(size: 60)).padding(10).foregroundColor(Color("hotpink"))
            }
        }
    }
}

// MARK: - FUNCTIONS

func playLocalSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            player.setVolume(5.0, fadeDuration: 0)
            player.play()
        } catch {
            print("Sound file not found")
        }
    }
}

// get rid of void returning functions bum

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
