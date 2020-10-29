//
//  ContentView.swift
//  A 2NiNG4K
//
//  Created by Peter Victoratos on 10/12/20.

import SwiftUI

struct ContentView: View {
    var timeHasPassed = false
    
    var body: some View {
        //z stack with the track shelf on top of everything
                //it is offset practically out of the frame other than the bottom which can be tapped to open. user can access the song library from there
        ZStack {
            TrackShelf()
                .offset(x: -60, y: -440.0)
            //should animate up and down on tap
            VStack {
                HStack {
                    //song title that fades into metadata
                    Spacer()
                    Text(timeHasPassed ? "song title" : "song metadata")
                    
                    //should be the frame width minus some
                    Spacer(minLength: 120)
                    
                    //add song button +
                    Button(action: {
                        print("new song")
                    }) {
                        //new song, saves song locally
                        //or maybe this is a button that expands into other options..? profile, effects etc
                        
                        Image(systemName: "plus")
                    }
                    Spacer()
                }.offset(x: 0, y: -260)
            }
                    //transparent backed group box consisting of 4 tracks with custom knobs and with some type of color varient
                        //has + underneath. on tap { add tracks }
                            // • • +
                    
                    //an animating metronome, when tapped it will make sounds. **always plays a "chiller" veresion of the sound before a recording commences**

                    //an h stack with a bar in between the amount of bars the tracks have followed by the BPM it is at

                    //an h stack that has the record/play/pause button along with skipping buttons in each direction by BARS
        }
        
        //we do need an add track button too
        
        //im not sure what things i am allowed to init outside of the view for it to work properly ????
        Text("yo")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
