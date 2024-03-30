//
//  GolfScorecardView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/31/24.
//

import SwiftUI

struct GolfScorecardView: View {
    
    var scores: [Score]
    var golfers: [Golfer]
    
    let holes = Array(1...18)
    
    let hole = Array(1...1)
    
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    ZStack {
                        Rectangle()
                            .frame(width: 100, height: 50)
                        Image(systemName: "figure.golf")
                            .frame(width: 40, height: 30)
                            .background(.white)
                    }
                    ForEach(golfers, id: \.self) { golfer in
                        Text(golfer.name)
                            .frame(width: 100, height: 50)
                            .background(.green.gradient)
                    }
                }
        
                ScrollView(.horizontal) {
                    VStack(spacing: 0) {
                        ForEach(hole, id: \.self) { _ in
                            HStack(spacing: 0) {
                                ForEach(self.holes, id: \.self) { holes in
                                    HStack(spacing: 0) {
                                        Text("\(holes)")
                                            .frame(width: 100, height: 50)
                                            .background(.blue.gradient)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height/3)
            }
        }
    }
}

//#Preview {
//    GolfScorecardView(scores: [Score.bad, Score.decent], 
//                      golfers: [Golfer.anon, Golfer.snoop])
//}
