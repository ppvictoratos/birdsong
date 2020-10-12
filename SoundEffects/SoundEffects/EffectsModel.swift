//
//  EffectsModel.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/23/20.
//

import Combine
import Foundation
import AVFoundation

class EffectsModel {
    
    struct AudioSession {
        var session = AVAudioSession()
        var sampleURL = URL(fileURLWithPath: "OutskirtStand.mp3")
        var recorder = AVAudioRecorder()
    }
    
}

//this is where the magic will happen

//I'd like to build some effects for my guitar & REALLY want to make a vocoder
