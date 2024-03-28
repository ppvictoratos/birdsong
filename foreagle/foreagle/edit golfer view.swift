//
//  edit golfer view.swift
//  foreagle
//
//  Created by Petie Positivo on 1/27/24.
//

import SwiftData
import SwiftUI

struct EditGolferView: View {
    @Bindable var golfer: Golfer
    
    var body: some View {
        Form {
            TextField("Name", text: $golfer.name)
        }
    }
}


