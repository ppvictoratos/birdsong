//
//  ContentView.swift
//  foreagle
//
//  Created by Petie Positivo on 1/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var games: [Game]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(games) { game in
                    NavigationLink {
                        GolfLogo()
                    } label: {
                        Text(game.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                    }
                }
                .onDelete(perform: deleteGames)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addGame) {
                        Label("Add Game", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select a game")
        }
    }

    private func addGame() {
        withAnimation {
            let newGame = Game(timestamp: Date(), golferScore: [0 : [1,2,3], 1 : [3, 4, 5]])
            modelContext.insert(newGame)
        }
    }

    private func deleteGames(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(games[index])
            }
        }
    }
}

struct GolfLogo: View {
    var body: some View {
        Image(systemName: "figure.golf")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay{
                Circle().stroke(.white, lineWidth: 2)
            }
        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Game.self, inMemory: true)
}
