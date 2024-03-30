//
//  ContentView.swift
//  SUIOneTwoThree
//
//  Created by Peter Victoratos on 6/17/20.
//  Copyright © 2020 loveshakk. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MainMenu(gameModeRef: gameMode.addition)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MASTER TO DO LIST:

// Clean up UI so it's not as magic
//Create a Game View that has:

//a mode selector.. sliders?
//what looks the best?
//a difficulty selector
//a start button
//starts out as a whiteboard, with all operators shown

// BY SUNDAY ^^^^^^
// AFTER SUNDAY vvvvv
//a background that changes color based upon mode & generates more
    //operator signs dependent on how difficult
