//
//  ContentView.swift
//  Lightning
//
//  Created by Peter Victoratos on 12/4/20.
//

import SwiftUI
import Metal

//Make the entire AnimatableVector generic, which you could do if you constrain the generic type to FloatingPoint

//what does the AnimatableVector struct do?
    // • creates var values: [Double]
    // • sets values to repeating: 0.0, count: 1 & magnitudeSquared = 0.0
    // • sets values = values: [Double] & magnitudeSquared = 0 & recomputeMagnitude

        //values.reduce(Double(), { magnitude, val in magnitude + (val * val)} to computeMagnitude & recompute calls & sets it again
        //it then needs to define these functions:
            // • magnitudeSquared, scale, zero = AnimatableVector(), +, -, +=, -=

func AnimatableVectorPF<A, B, C>(_ f: @escaping (A, B) -> C) where A: FloatingPoint, B: FloatingPoint, C: FloatingPoint{
    
    
    
}




















struct AnimatableVector: VectorArithmetic {
    
    var values: [Double]
    
    init(count: Int = 1) {
        self.values = [Double](repeating: 0.0, count: count)
        self.magnitudeSquared = 0.0
    }
    
    init(with values: [Double]) {
        self.values = values
        self.magnitudeSquared = 0
        self.recomputeMagnitude()
    }
    
    func computeMagnitudePF() -> Double {
        return values.reduce(Double(), { magnitude, val in magnitude + (val * val)})
    }
    
    mutating func recomputeMagnitude(){
        self.magnitudeSquared = self.computeMagnitudePF()
    }
    
    // MARK: VectorArithmetic
    var magnitudeSquared: Double // squared magnitude of the vector
    
    mutating func scale(by rhs: Double) {
        _ = values.map { $0 * rhs}
        self.magnitudeSquared = self.computeMagnitudePF()
    }
    
    // MARK: AdditiveArithmetic
    
    // zero is identity element for aditions
    // = all values are zero
    static var zero: AnimatableVector = AnimatableVector()
    
    static func + (lhs: AnimatableVector, rhs: AnimatableVector) -> AnimatableVector {
        var retValues = [Double]()
        
        for index in 0..<min(lhs.values.count, rhs.values.count) {
            retValues.append(lhs.values[index] + rhs.values[index])
        }
        
        return AnimatableVector(with: retValues)
    }
    
    static func += (lhs: inout AnimatableVector, rhs: AnimatableVector) {
        for index in 0..<min(lhs.values.count,rhs.values.count)  {
            lhs.values[index] += rhs.values[index]
        }
        lhs.recomputeMagnitude()
    }

    static func - (lhs: AnimatableVector, rhs: AnimatableVector) -> AnimatableVector {
        var retValues = [Double]()
        
        for index in 0..<min(lhs.values.count, rhs.values.count) {
            retValues.append(lhs.values[index] - rhs.values[index])
        }
        
        return AnimatableVector(with: retValues)
    }
    
    static func -= (lhs: inout AnimatableVector, rhs: AnimatableVector) {
        for index in 0..<min(lhs.values.count,rhs.values.count)  {
            lhs.values[index] -= rhs.values[index]
        }
        lhs.recomputeMagnitude()
    }
    
}


struct VectorField {
    let sizeX: Int
    let sizeY: Int
    var vector: AnimatableVector
    
    init ( sizeX: Int, sizeY: Int, range: ClosedRange<Double> ) {
        self.sizeX = sizeX
        self.sizeY = sizeY
        
        self.vector = VectorField.generateVectorField(sizeX: sizeX, sizeY: sizeY, range: range)
    }
    
    func valueAt(x: Int, y: Int) -> Double {
        return vector.values[y*self.sizeX + x]
    }
    
    func interpolatedValueAt(x: CGFloat, y: CGFloat)->Double? {
        let iX: CGFloat = floor(x)
        let iY: CGFloat = floor(y)
        guard Int(iX)<sizeX-1 && Int(iY)<sizeY-1 else { return nil}
        
        let fX: Double = 1.0 - Double(x-iX)
        let fY: Double = 1.0 - Double(y-iY)
        
        let val = self.valueAt(x: Int(iX), y: Int(iY))
        let rightVal = self.valueAt(x: Int(iX)+1, y: Int(iY))
        let bottomVal = self.valueAt(x: Int(iX), y: Int(iY)+1)
        let rightBottomVal = self.valueAt(x: Int(iX)+1, y: Int(iY)+1)
        
        let interpolA = val*fX + rightVal*(1.0-fX)
        let interpolB = bottomVal*fX + rightBottomVal*(1.0-fX)
        return interpolA*fY + interpolB*(1.1-fY)
    }
    
    func interpolatedValueAt(normX: CGFloat, normY: CGFloat)->Double? {
        return self.interpolatedValueAt(x: normX*CGFloat(sizeX), y: normY*CGFloat(sizeY))
    }
    
    static func generateVectorField(sizeX: Int, sizeY: Int, range: ClosedRange<Double>) -> AnimatableVector {
        var valueArray = [Double]()
                
        for y in 0..<sizeY {
            for x in 0..<sizeX {
                let rand = Double.random(in: -2...2)
                
                let dx = Double(x) - Double(sizeX)/2.0
                let dy = Double(y) - Double(sizeY)/2.0
                
                valueArray.append(tan(dx*dy) + rand + Double.pi)
            }
        }
        
        return AnimatableVector(with: valueArray)
    }
}

struct VectorFieldFollowShape: Shape {
    var field: VectorField
    let startPoint: CGPoint// = CGPoint(x: CGFloat.random(in: 0...1), y: CGFloat.random(in: 0...1))
    
    var animatableData: AnimatableVector {
        get { return field.vector}
        set { field.vector = newValue}
    }
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            let width = rect.width
            let height = rect.height
            
            let maxiter = 50
            let step:CGFloat = 10
            
            var pointPix = CGPoint(x: startPoint.x*width, y: startPoint.y*height)
            path.move(to: pointPix)
            
            var iter = 0
            while (pointPix.x<width && pointPix.y<height && pointPix.x>=0 && pointPix.y>=0 && iter<maxiter) {
                let normX = pointPix.x/width
                let normY = pointPix.y/height
                if let angle = field.interpolatedValueAt(normX: normX, normY: normY) {
                    pointPix = CGPoint(x: pointPix.x + CGFloat(cos(angle))*step, y: pointPix.y + CGFloat(sin(angle))*step)
                    path.addLine(to: pointPix)
                    iter += 1
                }
                else {
                    iter = maxiter // sort of break
                }
            }
        }
    }
}

let sizeX = 10
let sizeY = 10

func generateOrigins(count: Int)->[CGPoint] {
    var arr = [CGPoint]()
    for _ in 0..<count {
        arr.append(CGPoint(x: Double.random(in: 0...1), y: Double.random(in: 0...1)))
    }
    return arr
}

struct ContentView: View {
    static let count = 500
    @State var field: VectorField = VectorField(sizeX: sizeX, sizeY: sizeY, range: 0...2*Double.pi)
    @State var startX: CGFloat = 0.5
    @State var startY: CGFloat = 0.5
    let startingPoints = generateOrigins(count: Self.count)
    
    func animate() {
        let duration = 3.0
        withAnimation(.easeInOut(duration: duration)) {
            self.field = VectorField(sizeX: sizeX, sizeY: sizeY, range: 0...2*Double.pi)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + duration*0.3) {
            self.animate()
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
            ZStack {
                ForEach (0..<Self.count) { index in
                    VectorFieldFollowShape(field: field, startPoint: startingPoints[index])
                        .stroke(Color.white, lineWidth: 3.0)
                        .hueRotation(Angle(radians: 0.5+Double((startingPoints[index].x-0.5)*(startingPoints[index].y)-0.5)*2.0))
                        .drawingGroup()
                        .opacity(0.2)
                        .blendMode(.plusLighter)
                    }
            }
            .blur(radius: 5)
                ZStack {
                    ForEach (0..<Self.count) { index in
                        VectorFieldFollowShape(field: field, startPoint: startingPoints[index])
                            .stroke(Color.orange, lineWidth: 0.5)
                            .hueRotation(Angle(radians: Double((startingPoints[index].x-0.5)*(startingPoints[index].y)-0.5)*2.0))
                            .drawingGroup()
                            .opacity(0.3)
                            .blendMode(.plusLighter)
                        }
                }
                .opacity(0.5)
                
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.black)
            .drawingGroup()
            .offset(x: geometry.size.width/10/2, y: geometry.size.height/10/2)
        }
        
        
        .onTapGesture {
            self.animate()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
