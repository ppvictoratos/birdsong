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

//generator unit - to create audio according to a dsp
    // w/o midi - kAudioUnitType_Generator
    // w midi - kAudioUnitType_MusicDevice
//effect unit - to modify audio according to a dsp
    // w/o midi - kAudioUnitType_Effect
    // w midi - kAudioUnitType_MusicEffect


//may need some objc
//    @implementation AudioUnitViewController {
//        AUAudioUnit *audioUnit;
//    }
//
//    - (AUAudioUnit *)createAudioUnitWithComponentDescription:(AudioComponentDescription)desc error:(NSError **)error {
//        audioUnit = [[MyAudioUnit alloc] initWithComponentDescription:desc error:error];
//
//        // Check if the UI has been loaded
//        if(self.isViewLoaded) {
//            [self connectUIToAudioUnit];
//        }
//
//        return audioUnit;
//    }
//
//    - (void) viewDidLoad {
//        [super viewDidLoad];
//
//        // Check if the Audio Unit has been loaded
//        if(audioUnit) {
//            [self connectUIToAudioUnit];
//        }
//    }
//
//    - (void)connectUIToAudioUnit {
//        // Get the parameter tree and add observers for any parameters that the UI needs to keep in sync with the Audio Unit
//    }
//
//    @end


// Import audio

// Create a soundwave function?

//

// Make an audio gain function.
//var au = AudioUnit(bitPattern: 0)

// display the audio wave

// make a slider to adjust


// eventually audio HAL

// (remove noise, record, store music)


// convert/grab your recordings.

//let engine = AVAudioEngine()
//let speedControl = AVAudioUnitVarispeed()
//let pitchControl = AVAudioUnitTimePitch()

//func play(_ url: URL) throws {
//    // 1: load the file
//    let file = try AVAudioFile(forReading: url)
//
//    // 2: create the audio player
//    let audioPlayer = AVAudioPlayerNode()
//
//    // 3: connect the components to our playback engine
//    engine.attach(audioPlayer)
//    engine.attach(pitchControl)
//    engine.attach(speedControl)
//
//    // 4: arrange the parts so that output from one is input to another
//    engine.connect(audioPlayer, to: speedControl, format: nil)
//    engine.connect(speedControl, to: pitchControl, format: nil)
//    engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)
//
//    // 5: prepare the player to play its file from the beginning
//    audioPlayer.scheduleFile(file, at: nil)
//
//    // 6: start the engine and player
//    try engine.start()
//    audioPlayer.play()
//}

//override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//    pitchControl.pitch += 50
//    speedControl.rate += 0.1
//}


///Recording
//var tuningSession: AVAudioSession!
//var recorder: AVAudioRecorder!

//ask for user's permission to use mic
//recordingSession = AVAudioSession.sharedInstance()

//    do {
//        try recordingSession.setCategory(.playAndRecord, mode: .default)
//        try recordingSession.setActive(true)
//        recordingSession.requestRecordPermission() { [unowned self] allowed in
//            DispatchQueue.main.async {
//                if allowed {
//                    self.loadRecordingUI()
//                } else {
//                    // failed to record!
//                }
//            }
//        }
//    } catch {
//        // failed to record!
//    }

//    func loadRecordingUI() {
//        recordButton = UIButton(frame: CGRect(x: 64, y: 64, width: 128, height: 64))
//        recordButton.setTitle("Tap to Record", for: .normal)
//        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
//        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
//        view.addSubview(recordButton)
//    }

//    func startRecording() {
//        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
//
//        let settings = [
//            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//            AVSampleRateKey: 12000,
//            AVNumberOfChannelsKey: 1,
//            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//        ]
//
//        do {
//            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.delegate = self
//            audioRecorder.record()
//
//            recordButton.setTitle("Tap to Stop", for: .normal)
//        } catch {
//            finishRecording(success: false)
//        }
//    }

//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }

//    func finishRecording(success: Bool) {
//        audioRecorder.stop()
//        audioRecorder = nil
//
//        if success {
//            recordButton.setTitle("Tap to Re-record", for: .normal)
//        } else {
//            recordButton.setTitle("Tap to Record", for: .normal)
//            // recording failed :(
//        }
//    }

//    @objc func recordTapped() {
//        if audioRecorder == nil {
//            startRecording()
//        } else {
//            finishRecording(success: true)
//        }
//    }

//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if !flag {
//            finishRecording(success: false)
//        }
//    }

