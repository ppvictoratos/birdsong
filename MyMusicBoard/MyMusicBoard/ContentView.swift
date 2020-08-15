//
//  ContentView.swift
//  circles
//
//  I would like an application where users can easily highlight the songs they are listening to, weekly. The hopes is that users can look back on their calendar and "relive" feelings via the music they were listening to and share this with others.
//
//  Created by Peter Victoratos on 8/11/20.
//

import SwiftUI

struct ContentView: View {
    static var numCircles = 3
    static var tau = CGFloat(2.0 * 3.14159265358979323846)
    static var fourFifths = CGFloat(0.8)
    static var circleSize = fourFifths/10.0
    
    //wendell underlined boundingBox and square.. it seems I need to custom define those to be a circle that is the same size as the user image
    
    var body: some View {
            GeometryReader { boundingBox in
                VStack {
                    Spacer()
                    HStack {
                        ZStack{
                            Image("shneaky")
                                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                .shadow(radius:10)
                                .overlay(Circle()
                                            .stroke(Color.white, lineWidth: 5))
                                .scaleEffect(ContentView.fourFifths - 0.3, anchor: .center)
                                .offset(x: 35, y: 0)
                        GeometryReader { square in
                            ForEach(0 ..< ContentView.numCircles) { i in
                                //replace these circles with buttons that allow user to click into and get more data, a hero animation would be great
                                Image("spoofy")
                                    .frame(
                                        width: boundingBox.size.width * ContentView.circleSize + 300, //translates on x
                                        height: boundingBox.size.width * ContentView.circleSize + 65, //scales
                                        alignment: .center
                                    ) //circle size
                                    .scaleEffect(0.025)
                                    .offset(self.position(boundingBox, for: i))
                            }
                        }
                        }
                        .frame(
                            width: ContentView.fourFifths * boundingBox.size.width + 10,
                            height: ContentView.fourFifths * boundingBox.size.width + 10,
                            alignment: .center
                        ) // box size
                    }
                    Text("shneakypete")
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .offset(x: 50 , y: 20)
                    Spacer()
                    Button(action: {
                        
                    }) {
                        Text("yo")
                    }
                    Spacer()
                    }
            }
            .background(Color.black)
            .frame(width: 375, height: 825, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) //replace magic numbers with system dimensions
    }
    
    //this position func should probably utilize the unit circle to lay out the dots
    
    func initialPosition(boundingBox g: GeometryProxy) -> CGSize {
        CGSize(
            width: g.size.width * CGFloat(0.8) / 2.0
                - g.size.width * CGFloat(0.8) / 20.0,
            //why is this g.size.width?
            height: 0.0
        )
    }
    
    func position(_ g: GeometryProxy, for i: Int) -> CGSize{
        let pos = initialPosition(boundingBox: g)
        
        return CGSize(
            //cos of numCircles * (2Pi / numCircles)
            width: pos.width - 4.0 +
                (cos(CGFloat(i) * ContentView.tau / CGFloat(ContentView.numCircles)) * g.size.width * 0.45),
            height: pos.width + 75.0 +
                (sin(CGFloat(i) * ContentView.tau / CGFloat(ContentView.numCircles)) * g.size.width * 0.45)
        )
    }
}

struct MediaPlayoutMenu: View {
    @State private var volume: Double = 0
    
    var body: some View {
            Spacer()
            HStack{
                Spacer()
                Image(systemName: "play.fill")
                Image(systemName: "pause.fill")
                Image(systemName: "speaker.fill")
                Slider(value: $volume, in: 0...100, step: 1)
                //slider
                Spacer()
            }
                .font(.largeTitle)
                .foregroundColor(.white)
                .background(Color.green)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
