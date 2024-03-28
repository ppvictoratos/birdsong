//
//  ScorecardView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/30/24.
//

import SwiftUI

struct ScorecardView: View {
    var body: some View {
        Grid(horizontalSpacing: 2.0, verticalSpacing: 2.0) {
                       GridRow {
                           Rectangle().fill(.green.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.yellow.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.green.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.yellow.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.green.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.yellow.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.green.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.yellow.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.green.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.yellow.gradient)
                               .frame(width: 50.0, height: 50.0)
           
                       }.border(.primary, width: 5.0)
                       
                       GridRow {
                           Rectangle().fill(.blue.gradient)
                               .frame(width: 50.0, height: 50.0)
                           
                           Rectangle().fill(.purple.gradient)
                               .frame(width: 50.0, height: 50.0)
           
                       }.border(.primary, width: 5.0)
                   }
                   .padding(10.0)
                   .border(.primary)
    }
}

#Preview {
    ScorecardView()
}
