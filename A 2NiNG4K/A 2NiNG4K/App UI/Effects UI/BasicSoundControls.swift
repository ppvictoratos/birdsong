//
//  BasicSoundControls.swift
//  A 2NiNG4K
//
//  Created by Peter Victoratos on 11/1/20.
//

import SwiftUI
import AVFoundation

struct BasicSoundControls: View {
    var audioPlayer = AVAudioPlayer()
    let metronomeImage = UIImage(systemName: "metronome")?.cgImage
    @State var volume: Float
    
    var body: some View {
        
        VStack {
            Spacer()
            
        //metronome
            Image(decorative: metronomeImage!, scale: 0.7, orientation: .up)
                .padding(.bottom, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            
            
        //bpm //bars
        HStack {
            BPMText()
            BarsText()
        }
        .padding(.bottom, 10)
        
        //-4 bars, pause/record/play, +4 bars
        PlaybackControls(audioPlayer: audioPlayer)
            
            //master volume
            Slider(value: Binding(get: {volume}, set: {
                (newValue) in
                volume = newValue
            })).padding()
            
            Spacer()
        }
        .padding(.all, 0.0)
    }
}

//could probably make one view that both of these can use to format text & eventually use it as a button that can read values from the tracks

struct BPMText: View {
    var body: some View {
        VStack {
            Text("88")
            Text("BPM")
        }
    }
}

struct BarsText: View {
    var body: some View {
        VStack {
            Text("16")
            Text("Bars")
        }
    }
}

//Gotta rework this guy to accomidate multiple tracks

struct PlaybackControls: View { //View
    var audioPlayer: AVAudioPlayer
    var isPlaying: Bool = false
    
    var body: some View {
        HStack {
            Button(action: {
                audioPlayer.currentTime -= TimeInterval(10)
            }) {
                Image(systemName: "gobackward.10").foregroundColor(Color("AccentColor")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            Button(action: {
                //Play / Pause audio
                
                //isPlaying stays on even when paused
                audioPlayer.play()
                
            }) {
                Image(systemName:  audioPlayback(isPlaying: isPlaying))
                    .foregroundColor(Color("Earth1")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            Button(action: {
                //fast forward song 15 seconds
                audioPlayer.currentTime += TimeInterval(10)
            }) {
                Image(systemName: "goforward.10").foregroundColor(Color("AccentColor")).font(.system(size: 60))
            }
        }
    }
    
    func audioPlayback(isPlaying: Bool) -> String { return isPlaying ? "pause.circle.fill" : "play.circle.fill" }
    
}


struct BasicSoundControls_Previews: PreviewProvider {
    static var previews: some View {
        BasicSoundControls(volume: 0.5)
    }
}
