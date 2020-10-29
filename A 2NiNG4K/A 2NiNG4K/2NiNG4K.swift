//
//  2NiNG4K.swift
//  A 2NiNG4K
//
//  Main driver class for first iteration of the app
//  Main goal is to collaborate with Kanye with this.
//  Possibly create a reality where music is something everyone can offer (to pay with?)
//
//  Created by Peter Victoratos on 10/22/20.
//

import AVFoundation

infix operator >>>
public func >>> <A, B, C>(
    f: @escaping (A) -> B,
    g: @escaping (B) -> C
) -> (A) -> C {
    return { g(f($0)) }
}

struct G<A> { var a: A } // ((A) -> B) -> (G<A>) -> G<B>
enum   Gnum<A> { case a(A); case b } // ((A) -> B) -> (Gnum<A>) -> Gnum<B>
struct Gfunc<A> { var a: () -> A } // ((A) -> B) -> (Gfunc<A>) -> Gfunc<B>
struct Gcontrafunc<A> { var a: (A) -> Void } // ((B) -> A)  -> (Gcontrafunc<A>) -> Gcontrafunc<B>
struct Gjoinfunc<A>   { var a: (A) -> A } // ((A) -> B) -> ((B) -> A) -> (Gjoinfunc<A>) -> Gjoinfunc<B>

func map<A, B>(
    _ left: @escaping (B) -> A,
    _ right: @escaping (A) -> B //last time. why escaping?
) -> (Gjoinfunc<A>) -> Gjoinfunc<B> {
    { a in Gjoinfunc(a: (left >>> a.a) >>> right)}
}

struct Greducer<A, B, C> {
    var a: (A, B, C) -> (A, Array<B>)
    var b: (inout A, B, C) -> Array<B>
}


//Here's an index of some keywords

//Track: a single instance of an audio recording
//Full Track: a track that DOES have audio content in it
//Empty Track: a track that does not yet have audio content in it yet
//Knob: the little button on a track that tells the user how far along in playback they are
//Song (TBD): a combination of Tracks being played concurrently
//Audio Button: play, pause, record button

//Here is my list of requirements for Stage 1 of 2NiNG4K

//AVAudioEngine
//AVAudioRecorder (do I just need one or multiple?)
//AVAudioSession (multiple)
//Metronome (sound & visualization)
//Tempo (with adjustments)
//Song Library (audio store) for user to view/edit already created songs
//Native sliders
//Pause and Play controls
//Reset control
//New song button (warns you to save if in progress) +

//I'm going to build this out in one file. Will be presented as a View Struct
//I may have to go through this again and determine if Audio Units will make more sense
//Parts of code ordered by priority

//Music Library
//VIEW: TrackShelf will either be tappable or draggable from top left
//FUNX: Core Data to save the songs
//FUNX: it needs to store audio in an array to present in TrackShelf
//FUNX: It will save data from the audio engine
//FUNX: ADD BUTTON also with this, does a quicksave & store (auto names it?)

//Audio Engine
//FUNX: will have a recording node for each track
//FUNX: playback node can encorporate toggled tracks
//FUNX: will have a mixing node to not make our ears bleed
//L8RFUNX: will have effect nodes it can run through

//an audio player must be created with a track in order to play the data
//work must be done in the background thread
//looping audio must be done in a buffer, handled in completionHandler
//lastRenderTime needed to play players concurrently


//A TEST! .wav 44.1kHz/16bit.
//Make a copy of it and load it into an audio editor, inverse the phase and save it as is now.
//When you now schedule both version at exactly the same startTime (and of course with the same volume/pan settings) you will hear — SILENCE…


//if startFramePosition == nil {
//  audioPlayer.play(at: nil)
//  startFramePosition = (audioPlayer.lastRenderTime?.sampleTime)!
//  startTime = AVAudioTime.init(sampleTime: startFramePosition!, atRate: Double(self.mixer.rate))
//} else {
//  audioPlayer.play(at: startTime!)
//}

class TuningFork {
    //find a way to write audio files and save them locally so that we can retrieve them
        //use .wav
    //does xcode allow the simulator to write files to projects?
    
    private var audioFiles: Array<String> = ["01.mp3", "02.mp3", "10.mp3", "16.mp3"]
    private var audioEngine: AVAudioEngine = AVAudioEngine()
    private var mixer: AVAudioMixerNode = AVAudioMixerNode()
    
    func Play() {
        // do work in a background thread
        DispatchQueue.global(qos: .background).async {
            self.audioEngine.attach(self.mixer)
            self.audioEngine.connect(self.mixer, to: self.audioEngine.outputNode, format: nil)
            // !important - start the engine *before* setting up the player nodes
            try! self.audioEngine.start()
            
            _ = FileManager.default
            for _ in self.audioFiles {
                // Create and attach the audioPlayer node for this file
                let audioPlayer = AVAudioPlayerNode()
                self.audioEngine.attach(audioPlayer)
                // Notice the output is the mixer in this case
                self.audioEngine.connect(audioPlayer, to: self.mixer, format: nil)
                let fileUrl = NSURL.init(fileURLWithPath: self.audioFiles[0].removingPercentEncoding!)
                
                //how / WHERE do iterate through the audioFiles? i need to make a variable out of this loop that will be grabbed from a song picker. whatever the song picker is set to will distribute the song? which doesnt make sense because each track has its own audio player so for now im just going to have four auio players that map to ech of the audio files
                //if im feeling privy tomorrow morning i can record audio samples of different tracks
                
                //the key tonight is to get them all playing simulataniously
                
                //i cannot believe i have this job even though i failed algorithms analysis (almost twice). js
                
                // We should probably check if the file exists here ¯\_(ツ)_/¯
                //            try! AVAudioFile.init(forReading: fileUrl.absoluteURL!)
                
                audioPlayer.scheduleFile(try! AVAudioFile.init(forReading: fileUrl.absoluteURL!), at: nil, completionHandler: nil)
                audioPlayer.play(at: nil)
            }
        }
    }
}

//need to extend the tuning fork to be like customstringconvertible
    //what special property does the convertible have?
            //its a protocol

//i need to make a protocol that includes tuning fork. will it init properly? who knows


//can i have a witness?

//so it seems i cant make a witness out of this class above. i do need those inits however

//im sure there's a use for this somewhere..

let sampleTrack = TuningFork()

struct track<A> {
    let describe: (A) -> TuningFork
}

var tracks: [TuningFork] = []


//struct track: TuningFork {
//
//}

//Track Shelf
//VIEW: Will display all persisted songs as track cards
//VIEW: User can flick and pop it open, pushing it back will make the colors dance super quickly to compliment the speed of the flick (wow this is going to be a tough one)
//FUNX: choosing a song will open after a save is triggered on the current tracks

//Track Card
//VIEW:
//FUNX: Track cards will be scrollable & tappable

//Track Struct
//FUNX: have a selected/muted/unselected enum (knob cycles through the states)
//if selected it will play, if muted it will play muted, unselected it will stop wherever it is at
//selected = knob is pink color
//unselected = knob is white color
//muted = grey color (maybe a gray pink)

//Handle record func
//first time user is recording it asks for permission.. ?
//after first recording is done, user's permission is not asked for again
//selecting an empty track will create a new recording session and set the play button to be a record button

//playback func
//if there is a full track, the audio button will be a play button and will play that track
//if there are multiple tracks, the audio button will play them all by default
//user can deselect a track and it won't play

//Playback controls
//if there is at least one full track, the audio button will be a play and it will play all full tracks
//holding the rewind button fo 1.5 sec will reset all tracks to time = 0
//rewind will rewind 4 bars, allows for quick taps.
//fast foward button will go forward 4 bars

//Metronome View struct
//will be an animating view that ticks on beat with the BPM set by the user or the default
//if user taps, it will make noise (make this a really cool sound)

//Timing View Struct
//user will be able to change the time signature and BPM
//for now it will present a numeral keyboard, eventually something custom would be cool

//so the user initialily starts out with 4 blank tracks (white knobs). tempo is defaulted to 80 and visual metronome is on (but the sound is off) selecting a knob will make it "active". when user hits the record button they will get a countdown in time with their tempo. recording time is configurable by bars, at intervals of 4 up to 40 (for now). the point is to record until the end. stops at the end, does not wrap. once it is done, it is filled with a dot signifiying that it has audio in it. the record button is now a play button. if user selects a new, empty track, the play button goes back to record.

//TODO: Build UI, preload recorded tracks (drum machine, synth, bass and guitar) into it. Make sure they can play at once.
