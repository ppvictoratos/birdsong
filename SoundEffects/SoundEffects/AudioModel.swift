//
//  AudioModel.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/29/20.
//

import Foundation
import ComposableArchitecture
import Combine
import AVAudioSession
import AVAudioRecorder

public struct AudioState {
    public var session = AVAudioSession()
//    public var sampleURL = URL(fileURLWithPath: "OutskirtStand.mp3")
    public var recorder = AVAudioRecorder()

    public init(
        session: AVAudioSession = AVAudioSession(OutskirtStand),
        recorder: AVAudioRecorder = AVAudioRecorder(AVAudioRecorder)
    ) {
        self.session = session
        self.recorder = recorder
    }
}
