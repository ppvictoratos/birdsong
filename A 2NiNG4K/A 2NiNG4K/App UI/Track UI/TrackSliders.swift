//
//  TrackSliders.swift
//  A 2NiNG4K
//
//  Created by Peter Victoratos on 11/1/20.
//

import SwiftUI

struct TrackSliders: View {
    var body: some View {
        TrackSlider(times: [0.25, 0.5, 0.75, 1.0])
    }
}

//I want to squash this down, for Each? What's the best way to?
struct TrackSlider: View {
    @State var times: [Float]
    
    var body: some View {
        VStack {
            Slider(value: Binding(get: {times[0]}, set: {
                (newValue) in
                times[0] = newValue
            }))
            Slider(value: Binding(get: {times[1]}, set: {
                (newValue) in
                times[1] = newValue
            }))
            Slider(value: Binding(get: {times[2]}, set: {
                (newValue) in
                times[2] = newValue
            }))
            Slider(value: Binding(get: {times[3]}, set: {
                (newValue) in
                times[3] = newValue
            }))
        }
    }
}

struct TrackSliders_Previews: PreviewProvider {
    static var previews: some View {
        TrackSliders()    }
}
