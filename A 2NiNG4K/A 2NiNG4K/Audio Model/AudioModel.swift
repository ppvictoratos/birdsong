//
//  AudioModel.swift
//  A 2NiNG4K
//
//  Created by Peter Victoratos on 10/12/20.
//

import Foundation
import Combine
import ComposableArchitecture
import AVFoundation

public struct AudioState {
    
    public var player1: AVAudioPlayer = AVAudioPlayer()
    public var player2: AVAudioPlayer = AVAudioPlayer()
    
    public init(
        player1: AVAudioPlayer = AVAudioPlayer(),
        player2: AVAudioPlayer = AVAudioPlayer()
    ) {
        self.player1 = player1
        self.player2 = player2
    }
}

extension AudioState: Equatable { }
//extension AudioState: Codable { }

public extension AudioState {
    enum Action {
        case none
        case record
        case play
        case pause
        case volume
        case rewind
        case unwind
    }
}

public let audioReducer = Reducer<AudioState, AudioState.Action, AudioEnvironment> { state, action, env in
    switch action {
    case .none:
        return .none
    case .record:
        return .none
    case .play:
        return .none
    case .pause:
        return .none
    case .volume:
        return .none
    case .rewind:
        return .none
    case .unwind:
        return .none
    }
}

public struct AudioEnvironment {
    public init() { }
}

public struct AudioTestEnvironment {
    public init() { }
}



let urlA = Bundle.main.path(forResource: "01", ofType: "mp3", inDirectory: "Audio Files")
let urlB = Bundle.main.path(forResource: "02", ofType: "mp3", inDirectory: "Audio Files")
let urlC = Bundle.main.path(forResource: "10", ofType: "mp3", inDirectory: "Audio Files")
let urlD = Bundle.main.path(forResource: "16", ofType: "mp3", inDirectory: "Audio Files")
