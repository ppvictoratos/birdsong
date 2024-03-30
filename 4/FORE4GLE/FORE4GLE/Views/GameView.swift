//
//  GameView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/4/24.
//

import SwiftUI
import SwiftData

struct GameView: View {
    let stamp: String?
        
    var body: some View {
        if let stamp {
            GameCard(stamp: stamp)
        }
    }
}

private struct GameCard: View {
    let stamp: String
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Game.stamp.description) private var games: [Game]
    @State private var isEditorPresented = false
    
    init(stamp: String) {
        self.stamp = stamp
        let predicate = #Predicate<Game> { game in
            game.stamp.description == stamp
        }
        _games = Query(filter: predicate, sort: \Game.stamp.description)
    }
    
    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedGameStamp) {
            ForEach(games) { game in
                NavigationLink(game.stamp.description, value: game)
            }
            .onDelete(perform: removeGames)
        }
        .sheet(isPresented: $isEditorPresented) {
            EditGolferView(golfer: nil)
        }
        .overlay {
            if games.isEmpty {
                ContentUnavailableView {
                    Label("No games m8, get out there",
                          systemImage: "bird.fill")
                } description: {
                    AddGolferButton(isActive: $isEditorPresented)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddGolferButton(isActive: $isEditorPresented)
            }
        }
    }
    
    private func removeGames(at indexSet: IndexSet) {
        for index in indexSet {
            let gameToDelete = games[index]
            if navigationContext.selectedGame?.persistentModelID == gameToDelete.persistentModelID {
                navigationContext.selectedGameStamp = nil
            }
            modelContext.delete(gameToDelete)
        }
    }
}

private struct AddGolferButton: View {
    @Binding var isActive: Bool
    
    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add a game", systemImage: "figure.golf")
                .help("Add a game")
        }
    }
}

//#Preview("GameView") {
//    ModelContainerPreview(ModelContainer.sample) {
//        NavigationStack {
//            GameView(stamp: Game.game1.stamp.description)
//                .environment(NavigationContext())
//        }
//    }
//}
