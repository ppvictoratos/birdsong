//
//  NewGameView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 12/11/24.
//

import SwiftUI
import SwiftData

struct NewGameView: View {
    @Binding var navigationPath: NavigationPath
    @Environment(\.modelContext) private var modelContext
    @State private var playerNames: [String] = ["", "", "", ""]
    @State private var courseName: String = ""
    @State private var pars: [String] = Array(repeating: "3", count: 18)
    @State private var activeGolfers = 2

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.15, green: 0.25, blue: 0.2),
                    Color(red: 0.1, green: 0.18, blue: 0.15)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {
                    Text("New Game")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding(.top)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Course Name")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))
                        TextField("Enter course name", text: $courseName)
                            .textFieldStyle(.roundedBorder)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Players (select 2-4)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))

                        ForEach(0..<activeGolfers, id: \.self) { index in
                            TextField("Player \(index + 1)", text: $playerNames[index])
                                .textFieldStyle(.roundedBorder)
                        }

                        HStack(spacing: 8) {
                            if activeGolfers < 4 {
                                Button("+ Add Player") {
                                    activeGolfers += 1
                                }
                                .padding(8)
                                .background(Color(red: 0.2, green: 0.32, blue: 0.27))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            if activeGolfers > 2 {
                                Button("- Remove") {
                                    activeGolfers -= 1
                                }
                                .padding(8)
                                .background(Color.red.opacity(0.3))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                        }
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Par Scores (holes 1-18)")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.7))

                        VStack(spacing: 8) {
                            ForEach(0..<18, id: \.self) { hole in
                                HStack {
                                    Text("Hole \(hole + 1):")
                                        .frame(width: 80, alignment: .leading)
                                        .foregroundColor(.white)
                                    TextField("Par", text: $pars[hole])
                                        .textFieldStyle(.roundedBorder)
                                        .keyboardType(.numberPad)
                                        .frame(width: 50)
                                }
                            }
                        }
                    }

                    Button(action: createGame) {
                        Text("Create Game")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 0.2, green: 0.32, blue: 0.27))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.top)
                    .padding(.bottom)
                }
                .padding()
            }
        }
        .navigationTitle("New Game")
    }

    private func createGame() {
        let gameName = courseName.isEmpty ? "New Course" : courseName
        let course = Course(name: gameName, pars: [])
        modelContext.insert(course)

        let gameGolfers = playerNames.prefix(activeGolfers)
            .filter { !$0.isEmpty }
            .map { Golfer(name: $0, tagline: "", favoriteCourse: gameName) }

        gameGolfers.forEach { modelContext.insert($0) }

        let scores = gameGolfers.enumerated().map { index, _ in
            let parInts = pars.compactMap { Int($0) }
            return Score(id: Int.random(in: 1000..<9999), strokes: parInts.isEmpty ? Array(repeating: 0, count: 18) : parInts)
        }

        scores.forEach { modelContext.insert($0) }

        let game = Game(stamp: .now, golfers: gameGolfers, scores: scores)
        modelContext.insert(game)

        navigationPath.removeLast()
    }
}

#Preview {
    NewGameView(navigationPath: .constant(NavigationPath()))
}
