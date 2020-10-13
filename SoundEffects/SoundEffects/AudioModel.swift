////  AudioModel.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/29/20.
//

import Foundation
import ComposableArchitecture
import Combine
import AVFoundation
import CoreAudioKit
import CoreAudio //needs AUAudioUnitFactory

//if I have an AudioState, should I have a visualizer state?
//how does this work then?..
//[||||||.......] loading..
//so i use a view store for all of these models to live in and they communicate through those hallways

let urlC = Bundle.main.path(forResource: "JACKBOYS", ofType: "mp3")

public struct AudioState {
    public var session: AVAudioSession = AVAudioSession()
    public var recorder: AVAudioRecorder = AVAudioRecorder()
    //public var audioPlayer: AVAudioPlayer = AVAudioPlayer()

    public init(
        session: AVAudioSession = AVAudioSession(),
        recorder: AVAudioRecorder = AVAudioRecorder()
        //audioPlayer: AVAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlC!))
    ) {
        self.session = session
        self.recorder = recorder
        //self.audioPlayer = audioPlayer
    }
}

extension AudioState: Equatable { }
//extension AudioState: Codable { } why this no work?

public extension AudioState {
    enum Action {
        case none
        case record
        case playback
        case pause
        case gain
        case reverb
        case fun
    }
}

public let audioReducer = Reducer<AudioState, AudioState.Action, AudioEnvironment> { state, action, env in
    switch action {
        case .none:
            return .none
        case .record:
            state.session = AVAudioSession.sharedInstance()
            //how to get user's permission to allow recording?
            
            return .none
        case .playback:
            return .none
        case .pause:
            return .none
        case .gain:
            return .none
        case .reverb:
            return .none
        case .fun:
            return .none
    }
}

public struct AudioEnvironment {
    public init() { }
}

public struct AudioTestEnvironment {
    public init() { }
}


func startRecording() {
    var recorder: AVAudioRecorder = AVAudioRecorder()
    let audioFile = getDocumentsDirectory().appendingPathComponent("recording.m4a")
    let settings = [
        AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
        AVSampleRateKey: 12000,
        AVNumberOfChannelsKey: 1,
        AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
    ]
    //how to put recorder in here? or do I move this into AudioState?
    do {
        recorder = try AVAudioRecorder(url: audioFile, settings: settings)
        recorder.record()
    } catch {
        recorder.stop()
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
