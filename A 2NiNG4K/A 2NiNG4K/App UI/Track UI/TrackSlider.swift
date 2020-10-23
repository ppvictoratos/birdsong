//
//  TrackSlider.swift
//  A 2NiNG4K
//
//  Created by Peter Victoratos on 10/22/20.
//

import SwiftUI

struct TrackSlider: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TrackSlider_Previews: PreviewProvider {
    static var previews: some View {
        TrackSlider()
    }
}

// TODO: I will use this guide to build my custom track sliders
//https://medium.com/better-programming/reusable-components-in-swiftui-custom-sliders-8c115914b856
// Custom track slider will include:
    // unplayed track will be pink (right)
    // played track will be white (left)
    // knob with editable symbol (letter for now)
    // knob that is selectable (to record and then to play)
