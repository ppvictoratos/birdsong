//
//  MVPFlowView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/6/24.
//

import SwiftUI
import SwiftData

struct MVPFlowView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        NavigationSplitView(columnVisibility:
                                $navigationContext.columnVisibility) {
            GameListView()
                .navigationTitle(navigationContext.sidebarTitle)
        } content: {
            GameView(stamp:
                        navigationContext.selectedGameStamp)
            .navigationTitle(navigationContext.contentListTitle)
        } detail: {
            NavigationStack {
                GolfScorecardView(
                    scores: navigationContext.selectedGame?.scores,
                    golfers: navigationContext.selectedGame?.golfers)
            }
        }
    }
}

//#Preview {
//    ModelContainerPreview(ModelContainer.sample) {
//        MVPFlowView()
//            .environment(NavigationContext())
//    }
//}


