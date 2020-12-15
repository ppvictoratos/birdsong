//
//  ContentView.swift
//  AsnOw
//
//  Created by Peter Victoratos on 12/13/20.
//

import SwiftUI
import PureSwiftUI

private let numSegments = 12
private let innerRadiusRatio: CGFloat = 0.4
private let strokeStyle = StrokeStyle(lineWidth: 1, lineJoin: .round)
private let starLayoutConfig = LayoutGuideConfig.polar(rings: [0, innerRadiusRatio, 1], segments: 12)

struct Star: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var g = starLayoutConfig.layout(in: rect)
        
        path.move(g[2, 0])
        
        for segment in 1..<g.yCount {
            path.line(g[segment.isOdd ? 1 : 2, segment])
        }
        
        path.closeSubpath()
        
        return path
    }
}

struct Polygon: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        var g = starLayoutConfig.layout(in: rect)
        
        path.move(g[2, 0])
        
        for segment in 1..<g.yCount {
            path.line(g[2, segment])
        }
        path.closeSubpath()
        
        return path
    }
}

struct Snowflake: Shape {
    
    func path(in rect: CGRect) -> Path {
        let numCrystals = 7
        var layout = LayoutGuide.polar(rect, rings: [0.75], segments: numCrystals)
        var layoutSmall = layout.reframed(rect.scaled(0.9, at: rect.center), origin: .center)
        var path = Path()
        
        var g = starLayoutConfig.layout(in: rect)
        
        path.move(g[2,0])
        
        for segment in 0..<numCrystals {
            path.move(layoutSmall[0, 0, origin: layout[0, segment]])
            for smallSegment in 0...numSegments {
                path.line(layoutSmall[0, smallSegment, origin: layout[0, segment]])
            }
        }
        
        return path
    }
}

struct PolarLayoutStarDemo_Previews: PreviewProvider {
    struct PolarLayoutStarDemo_Harness: View {
        
        var body: some View {
            VStack(spacing: 50){
                Group {
                    Star()
                        .stroke(style: strokeStyle)
                        .layoutGuide(starLayoutConfig)
                    Polygon()
                        .stroke(style: strokeStyle)
                        .layoutGuide(starLayoutConfig)
                    Snowflake()
                        .stroke(style: strokeStyle)
                        .layoutGuide(starLayoutConfig)
                        .scaleEffect(0.5)
                    
                }
                .frame(250)
            }
        }
    }
    
    static var previews: some View {
        PolarLayoutStarDemo_Harness()
            .padding()
            .previewSizeThatFits()
            .showLayoutGuides(true)
    }
}

struct ContentView: View {
    var body: some View {
        Polygon().stroke(style: strokeStyle)
            .layoutGuide(starLayoutConfig)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
