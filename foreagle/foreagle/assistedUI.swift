//
//  assistedUI.swift
//  foreagle
//
//  Created by Petie Positivo on 1/27/24.
//

import Foundation
import SwiftUI

struct Player2: Codable, Identifiable {
    var id = UUID()
    var name: String
    var scores: [Int]
}

struct Game2: Codable {
    var course: String
    var date: Date
    var players: [Player2]
}

class GameManager: ObservableObject {
    static let shared = GameManager()
    
    @Published var players: [Player2] = []
    @Published var selectedCourse: String = ""
    @Published var currentGame: Game2?
    
    func startGame(players: [Player2], course: String) {
        guard !players.isEmpty, !selectedCourse.isEmpty else { return }
        let date = Date()
        let game = Game2(course: selectedCourse, date: date, players: players)
        self.currentGame = game
    }
    
    func endGame() {
        if let game = currentGame {
            saveGame(game)
            currentGame = nil
        }
    }
    
    private func saveGame(_ game: Game2) {
        // Save to local storage
        // Example: UserDefaults or FileManager
        // Here, we just print the game data
        print("Game saved:")
        print(game)
    }
}

struct ContentView3: View {
    @StateObject var gameManager = GameManager()
    @State private var playerName: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Players")) {
                        ForEach(gameManager.players) { player in
                            Text(player.name)
                        }
                        .onDelete { indexSet in
                            gameManager.players.remove(atOffsets: indexSet)
                        }
                    }
                    
                    Section(header: Text("Add Player")) {
                        TextField("Player Name", text: $playerName)
                        Button("Add") {
                            if !playerName.isEmpty {
                                gameManager.players.append(Player2(name: playerName, scores: Array(repeating: 0, count: 18)))
                                playerName = ""
                            }
                        }
                    }
                    
                    Section(header: Text("Select Course")) {
                        TextField("Course Name", text: $gameManager.selectedCourse)
                    }
                }
                .listStyle(.sidebar)
                
                Spacer()
                
                Button(action: {
                    gameManager.startGame(players: [Player2(name: "Pete", scores: [1, 2, 3])], course: "Hello")
                }, label: {
                    Text("Start Game")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding()
                
                Spacer()
                
                Button(action: {
                    gameManager.endGame()
                }, label: {
                    Text("End Game")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .padding()
            }
            .navigationTitle("Golf Scorecard")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//Paul Hudson's Preview looks like this

//#Preview {
//    do {
//        let config = ModelConfiguration(ModelConfiguration(isStoredInMemoryOnly: true))
//        let container = try ModelContainer(for: Golfer.self, configurations: config)
//        let golfer = Golfer(id: <#T##Int8#>, name: <#T##String#>, tagline: <#T##String#>)
//    }
//}
