//
//  UserView.swift
//  UserView
//
//  Created by Pete Victoratos on 9/9/21.
//  Copyright © 2021 loveshakk. All rights reserved.
//

import Foundation
import SwiftUI

struct UserView: View {
    var body: some View {
        ZStack {
            Image("green").resizable().edgesIgnoringSafeArea(.all)
        VStack {
            Image("perseon")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .clipped()
                .padding(.top, 44)
            
            Text("Johnny NJ")
                .font(.system(size: 20))
                .bold()
                .foregroundColor(.white)
                .padding()
        }
    }
    }
}
