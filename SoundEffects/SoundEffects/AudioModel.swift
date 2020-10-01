//
//  AudioModel.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/29/20.
//

import Foundation
import ComposableArchitecture
import Combine
import AVFoundation


public struct AudioState {
    public var session: AVAudioSession = AVAudioSession()
    public var recorder: AVAudioRecorder = AVAudioRecorder()

    public init(
        session: AVAudioSession = AVAudioSession(),
        recorder: AVAudioRecorder = AVAudioRecorder()
    ) {
        self.session = session
        self.recorder = recorder
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
            //how to get user's attention to allow recording?
            
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

//func application(_ application: UIApplication,
//                 didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//
//    // Get the singleton instance.
//    let audioSession = AVAudioSession.sharedInstance()
//    do {
//        // Set the audio session category, mode, and options.
//        try audioSession.setCategory(.playback, mode: .moviePlayback, options: [])
//    } catch {
//        print("Failed to set audio session category.")
//    }
//
//    // Other post-launch configuration.
//    return true
//}

func startRecording() {
    var recorder: AVAudioRecorder
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
