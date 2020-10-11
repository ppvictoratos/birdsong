//
//  NOT MINE.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 9/28/20.
//

import Foundation
import SwiftUI
  
struct Home : View {
      
      // slider ...
      // sample slider value...
      @State var value : CGFloat = 50
      
      var body: some View{
          
          VStack{
              
              ZStack {
                  HStack{
                      
                      Button(action: {}, label: {
                          
                          Image(systemName: "arrow.left")
                              .font(.system(size: 14, weight: .bold))
                              .foregroundColor(.gray)
                              .padding(.all)
                              .background(Color("Color"))
                              .clipShape(Circle())
                          // adding neuromorphic effect...
                              .shadow(color: Color("Color1").opacity(0.6),radius: 5,x: 5,y: 5)
                              .shadow(color: Color.white,radius: 5,x: -5,y: -5)
                      })
                      
                      Spacer()
                      
                      Button(action: {}, label: {
                          
                          Image(systemName: "line.horizontal.3.decrease")
                              .font(.system(size: 14, weight: .bold))
                              .foregroundColor(.gray)
                              .padding(.all)
                              .background(Color("Color"))
                              .clipShape(Circle())
                              .shadow(color: Color("Color1").opacity(0.6),radius: 5,x: 5,y: 5)
                              .shadow(color: Color.white,radius: 5,x: -5,y: -5)
                      })
                  }
                  
                  Text("Now Playing")
                      .fontWeight(.bold)
                      .foregroundColor(.gray)
              }
              
              // Track Image...
              
              Image("track")
                  .resizable()
                  .aspectRatio(contentMode: .fit)
              // automatic height adjustment when ever space is not available
                  .padding(.horizontal, 25)
                  .clipShape(Circle())
                  .padding(.all, 8)
                  .background(Color("Color").opacity(0.6))
                  .clipShape(Circle())
                  .shadow(color: Color.black.opacity(0.35),radius: 8,x: 8,y: 8)
                  .shadow(color: Color.white,radius: 10,x: -10,y: -10)
                  .padding(.top, 35)
              
              // Music Details...
              
              Text("Lose it")
                  .font(.title)
                  .fontWeight(.bold)
                  .foregroundColor(.gray)
                  .padding(.top, 25)
              
              Text("Flume ft Vic monica")
                  .font(.caption)
                  .foregroundColor(.gray)
                  .padding(.top, 8)
              
              // Timings...
              
              HStack{
                  
                  Text("1:15")
                      .font(.caption2)
                      .foregroundColor(.gray)
                  
                  Spacer()
                  
                  Text("1:15")
                      .font(.caption2)
                      .foregroundColor(.gray)
              }
              .padding(.top, 25)
              
              ZStack(alignment: Alignment(horizontal: .leading, vertical: .center), content: {
                  
                  Capsule()
                      .fill(Color.gray.opacity(0.2))
                      .frame(height: 6)
                  
                  ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
                      
                      Capsule()
                          .fill(Color("Color1").opacity(0.6))
                          .frame(width: value,height: 6)
                      
                      // Drag Button....
                      
                      Circle()
                          .fill(Color("Color1").opacity(0.7))
                          .frame(width: 10, height: 10)
                          .padding(.all, 10)
                          .background(Color("Color"))
                          .clipShape(Circle())
                      // adding shadow...
                          .shadow(color: Color("Color1").opacity(0.6),radius: 10,x: 4,y: 2)
                  }
              })
              // adding gesture...
              .gesture(DragGesture().onChanged({ (value) in
                  
                  // tracking location...
                  
                  // limiting value for only slider...
                  
                  // horizontal padding...
                  
                  if value.location.x <= UIScreen.main.bounds.width - 30 && value.location.x >= 0{
                      
                      self.value = value.location.x
                  }
                  
              }))
              .padding(.top, 8)
              
              
              // adding Playback Buttons...
              
              HStack(spacing: 20){
                  
                  Button(action: {}, label: {
                      
                      Image(systemName: "backward.fill")
                          .font(.system(size: 14, weight: .bold))
                          .foregroundColor(.gray)
                          .padding(.all, 25)
                          .background(Color("Color"))
                          .clipShape(Circle())
                      // adding shadow...
                          .shadow(color: Color("Color1").opacity(0.6),radius: 5,x: 5,y: 5)
                          .shadow(color: Color.white,radius: 5,x: -5,y: -5)
                  })
                  
                  Button(action: {}, label: {
                      
                      Image(systemName: "pause.fill")
                          .font(.system(size: 14, weight: .bold))
                          .foregroundColor(.white)
                          .padding(.all, 25)
                          .background(Color("Color1"))
                          .clipShape(Circle())
                      // adding shadow...
                          .shadow(color: Color("Color1").opacity(0.6),radius: 5,x: 5,y: 5)
                          .shadow(color: Color.white,radius: 5,x: -5,y: -5)
                  })
                  
                  Button(action: {}, label: {
                      
                      Image(systemName: "forward.fill")
                          .font(.system(size: 14, weight: .bold))
                          .foregroundColor(.gray)
                          .padding(.all, 25)
                          .background(Color("Color"))
                          .clipShape(Circle())
                      // adding shadow...
                          .shadow(color: Color("Color1").opacity(0.6),radius: 5,x: 5,y: 5)
                          .shadow(color: Color.white,radius: 5,x: -5,y: -5)
                  })
              }
              .padding(.top, 25)
              
              Spacer()
          }
          .padding(.all)
          .background(Color("Color").edgesIgnoringSafeArea(.all))
      }
  }

struct Home_Preview: PreviewProvider {
    static var previews: some View {
        Home()
    }
}


///  Created by Macbook on 7/30/20.
///  Copyright © 2020 Matt Pfeiffer. All rights reserved.
struct VerticalBar: View {
    
    @Binding var amplitude: Double
    
    var body: some View {
        GeometryReader
        { geometry in
            ZStack(alignment: .bottom){
                
                // Colored rectangle in back of ZStack
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.red, .yellow, Color("KW")]), startPoint: .top, endPoint: .center))
                
                // Dynamic black mask padded from bottom in relation to the amplitude
                Rectangle()
                    .fill(Color.black)
                    .mask(Rectangle().padding(.bottom, geometry.size.height * CGFloat(self.amplitude)))
                    .animation(.easeOut(duration: 0.15))
                
                // White bar with slower animation for floating effect
                Rectangle()
                    .fill(Color.white)
                    .frame(height: geometry.size.height * 0.005)
                    .offset(x: 0.0, y: -geometry.size.height * CGFloat(self.amplitude) - geometry.size.height * 0.02)
                    .animation(.easeOut(duration: 0.6))
                
            }
            .padding(geometry.size.width * 0.1)
            .border(Color.black, width: geometry.size.width * 0.1)
        }
    }
    
}

struct AmplitudeVisualizer: View {
    
    @Binding var amplitudes: [Double]
    
    var body: some View {
        HStack(spacing: 0.0){
            ForEach(0 ..< self.amplitudes.count) { number in
                VerticalBar(amplitude: self.$amplitudes[number])
            }
        }
        .background(Color.black)
    }
}
