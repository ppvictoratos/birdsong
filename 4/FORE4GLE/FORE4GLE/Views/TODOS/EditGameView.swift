//
//  EditGameView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/7/24.
//

import SwiftUI
import SwiftData

struct EditGameView: View {
    let game: Game?
    
    private var editorTitle: String {
        game == nil ? "Add Game" : "Edit Game"
    }
    
    //this should make more sense
    @State private var stamp = Date.now
    @State private var selectedCourse = Course.alleypond
    @State private var selectedGolfers = [Golfer.anon]
    @State private var selectedScores = [Score.bad]
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @Query(sort: \Game.stamp) private var games: [Game]
    
    var body: some View {
        NavigationStack {
            Form {
                Text(stamp.description)
            }
        }
    }
}
