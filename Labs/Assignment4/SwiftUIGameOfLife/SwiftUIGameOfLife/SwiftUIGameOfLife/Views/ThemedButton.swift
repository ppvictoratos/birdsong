//
//  ThemedButton.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 7/12/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//


import SwiftUI

struct ThemedButton: View {
    var text: String
    var action: () -> Void

    var body: some View {
        HStack {
            Spacer()
            Button(action: action) {
                // Your Problem 11 code codes goes below.
                VStack {
                    Text(text)
                        .font(.system(size: 13.0))
                        .frame(minWidth: 72.0, minHeight: 44.0)
                }
                .frame(width: 72.0, height: 44.0)
            }
            Spacer()
        }
        .frame(width: 80.0, height: 64.0)
        .fixedSize(horizontal: false, vertical: true)
    }
}

// MARK: Previews
struct ThemedButton_Previews: PreviewProvider {
    static var previews: some View {
        ThemedButton(text: "Step") { }
    }
}
