//
//  UserInputView.swift
//  SUIOneTwoThree
//
//  Created by Peter Victoratos on 6/21/20.
//  Copyright © 2020 loveshakk. All rights reserved.
//

import SwiftUI

struct UserInputView: View {
    @State var points = [Line]()
    
    var body: some View {
        
        Canvas { context, size in
            for line in points {
                var path = Path()
                path.addLines(line.points)
                
                context.stroke(path, with: .color(line.color), lineWidth: line.lineWidth)
            }
            
        }
                .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local).onChanged({ value in
                    let newPoint = value.location
                    if value.translation.width + value.translation.height == 0 {
                        points.append(Line(points: [newPoint], color: Color.white, lineWidth: 7))
                }else {
                    let index = points.count - 1
                    points[index].points.append(newPoint)
                }}))
        }
        
    }


struct UserInputView_Previews: PreviewProvider {
    static var previews: some View {
        UserInputView()
    }
}
