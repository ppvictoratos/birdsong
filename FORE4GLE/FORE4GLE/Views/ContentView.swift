//
//  ContentView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/27/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var navigationContext = NavigationContext()
    
    var body: some View {
        MVPFlowView()
            .environment(navigationContext)
    }
}

//#Preview {
//    ContentView()
//        .modelContainer(try! ModelContainer.sample())
//}
