//
//  ContentView.swift
//  AsnOw
//
//  Created by Peter Victoratos on 12/13/20.
//

import SwiftUI
import PureSwiftUI
import UIKit
import FLAnimatedImage

private let numSegments = 12
private let innerRadiusRatio: CGFloat = 0.4
private let strokeStyle = StrokeStyle(lineWidth: 2, lineJoin: .round)
private let starLayoutConfig = LayoutGuideConfig.polar(rings: [0, innerRadiusRatio, 1], segments: 12)

struct AnimatedImageView: UIViewRepresentable {
    let animatedView = FLAnimatedImageView()
    var fileName: String = "snowflake.png"
    
    func makeUIView(context: UIViewRepresentableContext<AnimatedImageView>) -> UIView {
        let view = UIView()
        
        let path: String = Bundle.main.path(forResource: fileName, ofType: "gif")!
        let url = URL(fileURLWithPath: path)
        let gifData = try! Data(contentsOf: url)
        
        let gif = FLAnimatedImage(animatedGIFData: gifData)
        animatedView.animatedImage = gif
        
        animatedView.translateAutoresizingMaskIntoContraints = false
        view.addSubview(animatedView)
        
        NSLayoutContraint.activate([
                                    animatedView.heightAnchor.constraint(equalTo: view.heightAnchor),
                                    animatedView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AnimatedImageView>) {
        <#code#>
    }
}

func randomFloat() -> CGFloat {
    return CGFloat(Double.random(in: 0.8..<1.25))
}

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
        let layout = LayoutGuide.polar(rect, rings: [0.5], segments: numCrystals)
        let layoutSmall = layout.reframed(rect.scaled(0.9, at: rect.center), origin: .center)
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

struct Snowflake2: Shape {
    var randomFloat: CGFloat
    var offset: CGFloat
    
    var animatableData: CGFloat {
        get { offset }
        set { offset = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let numCrystals = 7
        let layout = LayoutGuide.polar(rect, rings: [0.5], segments: numCrystals)
        //if we keep rings at 0.5, randomly generate a number between 0.8 and 1.25
        let layoutSmall = layout.reframed(rect.scaled(randomFloat, at: rect.center), origin: .center)
        var path = Path()
        
        var g = starLayoutConfig.layout(in: rect)
        
        path.move(g[2,0])
        path.move(to: CGPoint(x: 0, y: offset))
        for segment in 0..<numCrystals {
            path.move(layoutSmall[0, 0, origin: layout[0, segment]])
            for smallSegment in 0...numCrystals {
                path.line(layoutSmall[0, smallSegment, origin: layout[0, segment]])
            }
        }
        
        return path
    }
}


struct ParticleEmitterView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let size = CGSize(width: 824.0, height: 1112.0)
        let host = UIView(frame: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        
        let particlesLayer = CAEmitterLayer()
        particlesLayer.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        host.layer.addSublayer(particlesLayer)
        host.layer.masksToBounds = true
        
        particlesLayer.backgroundColor = UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        particlesLayer.emitterShape = .line
        particlesLayer.emitterPosition = CGPoint(x: 599.4, y: 0)
        particlesLayer.emitterSize = CGSize(width: 1648.0, height: 1112.0)
        particlesLayer.emitterMode = .surface
        particlesLayer.renderMode = .oldestLast
        
        let image1 = UIImage(named: "snowparticle")?.cgImage
        
        let cell1 = CAEmitterCell()
              cell1.contents = image1
              cell1.name = "Snow"
              cell1.birthRate = 62.0
              cell1.lifetime = 20.0
              cell1.velocity = 59.0
              cell1.velocityRange = -15.0
              cell1.xAcceleration = 5.0
              cell1.yAcceleration = 40.0
              cell1.emissionRange = 180.0 * (.pi / 180.0)
              cell1.spin = -28.6 * (.pi / 180.0)
              cell1.spinRange = 57.2 * (.pi / 180.0)
              cell1.scale = 0.04
              cell1.scaleRange = 0.3
              cell1.color = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor

              particlesLayer.emitterCells = [cell1]
              return host
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
}

struct ContentView: View {
    private let imageView: UIImage

    var body: some View {
        ZStack{
            Color.blue.edgesIgnoringSafeArea(.all)
            ParticleEmitterView().edgesIgnoringSafeArea(.all)
            Text("Merry Christmas!")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

