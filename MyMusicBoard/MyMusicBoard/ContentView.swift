//
//  ContentView.swift
//  MyMusicBoard
//
//  Created by Peter Victoratos on 8/6/20.
//

import SwiftUI

//make a struct that has 7 circles, in a circle

struct ContentView: View {
    var body: some View {
        ZStack {
            Image("userImage").clipShape(Circle()).shadow(radius: 10).overlay(Circle().stroke(Color.red, lineWidth: 5)).scaleEffect(0.3, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            FollowPath()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SongCircle: View {
    var body: some View {
        VStack {
            Circle().scaleEffect(0.3, anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).foregroundColor(.black)
            HStack {
                Circle().scaleEffect(0.3)
                Circle().scaleEffect(0.3)
            }
            HStack {
                Circle().scaleEffect(0.3)
                Circle().scaleEffect(0.3)
            }
            HStack {
                Circle().scaleEffect(0.3)
                Circle().scaleEffect(0.3)
            }
        }
    }
    
}

struct FollowPath: View {
    @State private var flag = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                Circle().stroke(Color.clear).frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                SongCircle().frame(width: 25, height: 25).offset(x: 0, y: 0)
                    .modifier(FollowEffect(pct: self.flag ? 1 : 0, path: CirclePath.create(in: CGRect(x: 0, y: 0, width: 0, height: 0))))
            }
        }
    }
}

struct FollowEffect: GeometryEffect {
    var pct: CGFloat = 0
    let path: Path
    var rotate = false
    
    var animatableData: CGFloat {
        get { return pct }
        set { pct = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        if !rotate {
            let pt = percentPoint(pct)
            
            return ProjectionTransform(CGAffineTransform(translationX: pt.x, y: pt.y))
        } else {
            let pt1 = percentPoint(pct)
            let pt2 = percentPoint(pct - 0.01)
            
            let a = pt2.x - pt1.x
            let b = pt2.y - pt1.y
            
            let angle = a < 0 ? atan(Double(b/a)) : atan(Double(b/a)) - Double.pi
            
            let transform = CGAffineTransform(translationX: pt1.x, y: pt1.y).rotated(by: CGFloat(angle))
            
            return ProjectionTransform(transform)
        }
    }
    
    func percentPoint(_ percent: CGFloat) -> CGPoint {
        let pct = percent > 1 ? 0 : (percent < 0 ? 1 : percent)
        let f = pct > 0.999 ? CGFloat(1-0.001) : pct
        let t = pct > 0.999 ? CGFloat(1) : pct + 0.001
        let tp = path.trimmedPath(from: f, to: t)
        
        return CGPoint(x: tp.boundingRect.midX, y: tp.boundingRect.midY)
    }
}

struct CirclePath: Shape {
    func path(in rect: CGRect) -> Path {
        return CirclePath.create(in: rect)
    }
    
    static func create(in rect: CGRect) -> Path {
        var path = Path()
        
        path.addEllipse(in: CGRect(x: 10, y: 10, width: 10, height: 10))
        
        return path
    }
}
