//
//  ContentView.swift
//  iChing
//
//  Created by Peter Victoratos on 2/15/21.
//

import Foundation
import SwiftUI

//TODO: Make each coin flip draw the corresponding hexagram line

//TODO: How to make it wrap at 9 dots?

//TODO: Implement TCA

//TODO: Make flip button increment the amount of FlipResults until there are 9
    //TODO: Change button to "View Hexagram"
    //TODO: Show hexagram based upon flip results
    //TODO: Change button to say

//TODO: Make CoinFlip a 3D object that the user can interact with
    //TODO: Once flipped, it becomes three separate coins
//TODO: Make the result of coin flip update the CoinFlipResults

//TODO: Make CoinFlipResult an H or T depending on flip
    //return an array of strings? map could be useful here
struct CustomDotView: View {
    let dots: Int
    
    private let dotDimension: CGFloat = 8.0
    private let rows = 2
    private let dotsPerRow = 9
    private let heightSpacing: CGFloat = 8.0
    
    private var contentHeight: CGFloat {
        let totalRowHeight = CGFloat(rows) * dotDimension
        let totalSPacing = CGFloat(rows - 1) * heightSpacing
        return totalRowHeight + totalSPacing
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(spacing: heightSpacing) {
                ForEach(0 ..< rows, id: \.self) { row in
                    HStack {
                        ForEach(0 ..< dotsPerRow, id: \.self) { dot in
                            Circle().foregroundColor(Color.accentColor)
                                .frame(width: dotDimension)
                                .opacity(((row * dotsPerRow) + dot) < dots ? 1.0 : 0.0)
                        }
                    }
                    .frame(width: proxy.size.width, height: dotDimension)
                }
            }
        }
        .frame(height: contentHeight)
    }
}


func flipCoin() -> String {
    return String(Bool.random())
}

struct FlipEffect: GeometryEffect {
    
    var animatableData: Double {
        get { angle }
        set { angle = newValue }
    }
    
    @Binding var flipped: Bool
    var angle: Double
    let axis: (x: CGFloat, y: CGFloat)
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        // We schedule the change to be done after the view has finished drawing,
        // otherwise, we would receive a runtime error, indicating we are changing
        // the state while the view is being drawn.
        DispatchQueue.main.async {
            self.flipped = self.angle >= 90 && self.angle < 270
        }
        
        let a = CGFloat(Angle(degrees: angle).radians)
        
        var transform3d = CATransform3DIdentity;
        transform3d.m34 = -1/max(size.width, size.height)
        
        transform3d = CATransform3DRotate(transform3d, a, axis.x, axis.y, 0)
        transform3d = CATransform3DTranslate(transform3d, -size.width/2.0, -size.height/2.0, 0)
        
        let affineTransform = ProjectionTransform(CGAffineTransform(translationX: size.width/2.0, y: size.height / 2.0))
        
        return ProjectionTransform(transform3d).concatenating(affineTransform)
    }
}

struct Card: View {
    @State private var flipped = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .foregroundColor(self.flipped ? .red : .blue)
            .padding()
            .rotation3DEffect(
                self.flipped ? Angle(degrees: 180): Angle(degrees: 0), axis: (x: CGFloat(10), y: CGFloat(0), z: CGFloat(0)))
            .animation(.default)
            .onTapGesture {
                self.flipped.toggle()
            }
    }
}

struct CoinFlip: View {
    @State private var flipped = false
    @State private var animate3d = false
    @State private var rotate = false
    @State private var imgIndex = 0
    
    let images = ["quarterBack1", "quarterBack2", "quarterBack3"]
    
    var body: some View {
        let binding = Binding<Bool>(get: { self.flipped }, set: { self.updateBinding($0) })
        
        return VStack {
            Spacer()
            Image(flipped ? "quarterFront" : images[imgIndex]).resizable()
                .frame(width: 280, height: 280)
                .modifier(FlipEffect(flipped: binding, angle: animate3d ? 360 : 0, axis: (x: 1, y: 5)))
                .rotationEffect(Angle(degrees: rotate ? 0 : 360))
                .onAppear {
                    withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                        self.animate3d = true
                    }
                    
                    withAnimation(Animation.linear(duration: 18.0).repeatForever(autoreverses: false)) {
                        self.rotate = true
                    }
                }
            Spacer()
        }
        
    }
    
    func updateBinding(_ value: Bool) {
        if flipped != value && !flipped {
            self.imgIndex = self.imgIndex + 1 < self.images.count ? self.imgIndex + 1 : 0
        }
        
        flipped = value
    }
}

struct CoinFlipResult: View {
    @State private var heads: Bool = true
    
    
    var body: some View {
        Circle()
            .frame(width: 12, height: 12)
    }
}

struct CoinFlipResultsTracker: View {
    @State var coins: Int
    
    struct Modifier: AnimatableModifier {
        var coinCount: Double
        
        var animatableData: Double {
            get { coinCount }
            set { coinCount = newValue }
        }
        
        func body(content: Content) -> some View {
            content.overlay(Text(String.init(repeating: ".", count: Int(coinCount)))
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/),
                            alignment: .leading)
        }
    }
    @State private var coinCount: Int = 17
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0...coins, id: \.self) {
                index in
                HStack {
                    CoinFlipResult()
                }
            }
        }
    }
}

struct ContentView: View {
    @State var coins = 0
    @State private var dotCount = 0
    
    private let dotRange = 0 ... 18
    
    
    var body: some View {
        
        VStack {
            
            Text("iChing")
                .padding()
                .font(.largeTitle)
            
            CustomDotView(dots: dotCount)
                .accentColor(Color.green)
                .animation(.easeInOut)
            
            Spacer()
            
            CoinFlip()
            
            Spacer()
            
            Stepper("Dots", value: $dotCount, in: dotRange)
                .padding(.horizontal, 16.0)
                .padding(.bottom, 40.0)
            
            Button("Flip!") {
                coins = coins + 1
            }
            .accentColor(.green)
            .font(.largeTitle)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

