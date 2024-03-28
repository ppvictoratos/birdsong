//
//  GameListView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/5/24.
//

import SwiftUI
import SwiftData

struct GameListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Game.stamp) private var games: [Game]
    @State private var isReloadPresented = false
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedGameStamp) {
            ListGames(games: games)
        }
        .alert("Reload sample data?", isPresented:
                $isReloadPresented) {
            Button("Yes, reload", role: .destructive) {
                reloadSampleData()
            }
        } message: {
            Text("Reloading the sample data deletes all changes to the current data.")
        }
        .toolbar {
            Button {
                isReloadPresented = true
            } label: {
                Label("", systemImage: "arrow.clockwise")
                    .help("Reload sample data")
            }
        }
        .task {
            if games.isEmpty {
                Game.insertSampleData(modelContext: modelContext)
            }
        }
    }
    
    @MainActor
    private func reloadSampleData() {
        navigationContext.selectedGameStamp = nil
        navigationContext.selectedGolferName = nil
        Game.reloadSampleData(modelContext: modelContext)
    }
}

private struct ListGames: View {
    var games: [Game]
    
    var body: some View {
        ForEach(games) { game in
            NavigationLink(game.stamp.description, value: game.stamp)
        }
    }
}

//#Preview("GamesListView") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            GameListView()
//        }
//        .environment(NavigationContext())
//    }
//}
//
//#Preview("ListGolfers") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            List {
//                ListGames(games: [.game1])
//            }
//        }
//    }
//}
