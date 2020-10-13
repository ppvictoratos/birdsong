//
//  ContentView.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/23/20.
//

import SwiftUI
import CoreAudioKit
import AVFoundation

//DONE: fix UI
//TODO: fix output volume (screen recording sounds is too loud)
//TODO: make app icon
//TODO: implement pause play
//TODO: get fun effect working - subwoofer toggle
//TODO: run animation/audio timer on background thread

let urlB = Bundle.main.path(forResource: "02", ofType: "mp3")

struct ContentView: View {
    @StateObject var album = album_Data() //now is this view or audio..?
    
    @State var audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlB!)) //audio7
    
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect() //audio7 (view might need its own?)
    //try publishing on a background thread
    //keep a timer thread 
    
    @State var maxWidth = UIScreen.main.bounds.width / 2.2 //view
    
    @State var loudEnough: Bool = false //don't need this
    
    @State var animatedValue: CGFloat = 55 //view
    
    @State var time: Float = 0 //audio7 (view might need its own?)
    
    var body: some View {
            VStack {
                SELogo()
                Slider(value: Binding(get: {time}, set: { (newValue) in
                    time = newValue
                    audioPlayer.currentTime = Double(time) * audioPlayer.duration
                    audioPlayer.play()
                })).padding(EdgeInsets(top: 45, leading: 45, bottom: 45, trailing: 45))
                ZStack {
                    VStack {
                        PlaybackControls(audioPlayer: audioPlayer)
                        EffectControls(audioPlayer: audioPlayer)
                    }
                    //WaveVisualizer() how did I do the subwoofer thing..?
                    ZStack{
                        Circle()
                            .fill(Color.white.opacity(0.10))
                        
                        Circle()
                            .fill(Color.white.opacity(0.12))
                            .frame(width: animatedValue / 2, height: animatedValue / 2)
                    }
                    .frame(width: animatedValue, height: animatedValue)
                    .offset(x: 0, y: -175)
                }
            }.onReceive(timer) { (_) in
            if audioPlayer.isPlaying {
                audioPlayer.updateMeters()
                time = Float(audioPlayer.currentTime / audioPlayer.duration)
                waveAnimation()
            }
            else {
                album.isPlaying = false
            }
        }.onAppear(perform: getAudioData)
    }
    
    func waveAnimation() {
        var power: Float = 0.0
        
        for i in 0..<audioPlayer.numberOfChannels {
            power += audioPlayer.averagePower(forChannel: i)
        }
        
        let normalize = max(0, power + 55)
        
        let animated = CGFloat(normalize) * (maxWidth / 55)
        
        withAnimation(Animation.linear(duration: 0.01)) {
            self.animatedValue = animated + 55
        }
    }
    
    func getAudioData(){
        
        audioPlayer.isMeteringEnabled = true
        
        // extracting audio data....
        
        let asset = AVAsset(url: audioPlayer.url!)
        
        asset.metadata.forEach { (meta) in
            
            switch(meta.commonKey?.rawValue){
            
            case "artwork": album.artwork = meta.value == nil ? UIImage(named: "music")!.pngData()! : meta.value as! Data
                
            case "artist": album.artist = meta.value == nil ? "" : meta.value as! String
                
            case "type": album.type = meta.value == nil ? "" : meta.value as! String
                
            case "title": album.title = meta.value == nil ? "" : meta.value as! String
                
            default : ()
            }
        }
        
        if album.artwork.count == 0{
            
            album.artwork = UIImage(named: "music")!.pngData()!
        }
    }
}

class album_Data : ObservableObject { // audio7
    
    @Published var isPlaying = false
    @Published var title = ""
    @Published var artist = ""
    @Published var artwork = Data(count: 0)
    @Published var type = ""
}

// MARK: - STRUCTS

struct SELogo: View { //view
    
    var body: some View {
        ZStack {
            Image(systemName: "tuningfork").foregroundColor(Color("KW")).font(.system(size: 90)).padding().offset(x: -2.5, y:0)
            Image(systemName: "tuningfork").foregroundColor(Color("hotpink")).font(.system(size: 90)).padding().offset(x:2.5,y:0)
        }
    }
}

struct WaveVisualizer: View { //View
    @State var animatedValue: CGFloat = 55
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color.white.opacity(0.10))
            
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: animatedValue / 2, height: animatedValue / 2)
        }
        .frame(width: animatedValue, height: animatedValue)
        .offset(x: -8, y: 0)
    }
}

struct PlaybackControls: View { //View
    var audioPlayer: AVAudioPlayer
    var paused: Bool = true
    
    var body: some View {
        HStack {
            Button(action: {
                audioPlayer.currentTime -= TimeInterval(10)
            }) {
                Image(systemName: "gobackward.10").foregroundColor(Color("MainColor")).font(.system(size: 60))
            }.padding(.trailing, 15)
            
            ZStack{
                Button(action: {
                    //Play / Pause audio
                    
                    //isPlaying stays on even when paused
                        audioPlayer.play()
                    
                }) {
                    Image(systemName:  audioPlayback(isPlaying: audioPlayer.isPlaying))
                        .foregroundColor(Color("hotpink")).font(.system(size: 60))
                }.padding(.trailing, 15)
            }
            
            Button(action: {
                //fast forward song 15 seconds
                audioPlayer.currentTime += TimeInterval(10)
            }) {
                Image(systemName: "goforward.10").foregroundColor(Color("MainColor")).font(.system(size: 60))
            }
        }
    }
    
    func audioPlayback(isPlaying: Bool) -> String { return isPlaying ? "pause.circle.fill" : "play.circle.fill" }

}

struct EffectControls: View { //View
    var audioPlayer: AVAudioPlayer
    
    var body: some View {
        VStack {
            //OVERKILL UNDO
            Button(action: {
                audioPlayer.setVolume(2.0, fadeDuration: TimeInterval(3))
            }) {
                Image(systemName: "arrow.uturn.left.square").font(.system(size: 60)).padding(10).foregroundColor(Color("KW"))
            }
            //INCREASE GAIN STATICLY
            Button(action: {
                audioPlayer.setVolume(20.0, fadeDuration: TimeInterval(3))
            }) {
                Image(systemName: "capslock").font(.system(size: 60)).padding(10).foregroundColor(Color("hotpink"))
            }
            //INCREASE REVERB STATICALLY
            Button(action: {
                //reverb
                audioPlayer.setVolume(0.0, fadeDuration: 0.0)
            }) {
                Image(systemName: "speaker").font(.system(size: 60)).padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).foregroundColor(Color("hotpink"))
            }
            //DOES SOMETHING FUN
            Button(action: {
                //fun effect
                //make subwoofer effect..
                    //i would have to build out two entirely different UI's..?
            }) {
                Image(systemName: "wand.and.rays").font(.system(size: 60)).padding(10).foregroundColor(Color("hotpink"))
            }
        }
    }
}

//have local sound take a sound, set a volume and play it, return the sound. that sound can be further edited through chaining

//for something fun: functionally compose multiple effects

// MARK: - FUNCTIONS

//make a function for rewind -> audio7


//make a function for forward -> audio7

//make a function for play/pause -> audio7

//make an undo function -> audio7

//make a reverb function -> audio7

//make a fun effect function -> audio7

//func createAudioUnit(soundPath: String) -> AUAudioUnit {
//    let au: AUAudioUnit = AUAudioUnit(componentDescription: audioName)
//    return au
//}

// MARK: - PREVIEWS
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .preferredColorScheme(.dark)
        }
    }
}
