//
//  FORE4GLEApp.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/27/24.
//

import SwiftUI

@main
struct FORE4GLEApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Game.self)
    }
}

//MARK: DEFINITES

// - Compare this to SwiftData Animal and see where you can clean it up. once running..
// - Watch integration so you don't need to use ur phone while playing

//MARK: POTENTIALS

// - Course sketcher
// - Potentials, after 9 call out. could i get siri to speak it out? or some other third party 

