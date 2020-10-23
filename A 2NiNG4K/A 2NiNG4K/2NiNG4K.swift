//
//  2NiNG4K.swift
//  A 2NiNG4K
//
//  Main driver class for first iteration of the app
//
//  Created by Peter Victoratos on 10/22/20.
//

import AVFoundation

//Here's an index of some keywords

//Track: a single instance of an audio recording
    //Full Track: a track that DOES have audio content in it
    //Empty Track: a track that does not yet have audio content in it yet
//Knob: the little button on a track that tells the user how far along in playback they are
//Song (TBD): a combination of Tracks being played concurrently
//Audio Button: play, pause, record button

//Here is my list of requirements for Stage 1 of 2NiNG4K

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

//Track Struct
    //Each track should have an AVAudioSession.. can you play multiple at once?
    //tracks should have a selected/muted/unselected enum (knob cycles through the states)
    //selected = pink color
    //unselected = white color
    //muted = grey color (maybe a gray pink)

//Handle record func
    //first time user is recording it asks for permission.. ? I feel like this should only be asked once and this permission should save. gotta look into how these permissions are dealt with currently
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
