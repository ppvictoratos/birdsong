//
//  GolferDetailView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 2/3/24.
//

import SwiftUI
import SwiftData

struct GolferDetailView: View {
    var golfer: Golfer?
    @State private var isEditing = false
    @State private var isDeleting = false
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationContext.self) private var navigationContext
    
    var body: some View {
        if let golfer {
            GolferDetailView(golfer: golfer)
                .navigationTitle("\(golfer.name)")
                .toolbar {
                    Button { isEditing = true } label: {
                        Label("Edit \(golfer.name)", systemImage: "pencil")
                            .help("Edit the golfer")
                    }
                    
                    Button { isDeleting = true } label: {
                        Label("Delete \(golfer.name)", systemImage: "trash")
                            .help("Delete the golfer")
                    }
                }
                .sheet(isPresented: $isEditing) {
                    //EditGolferView(golfer: golfer)
                }
                    .alert("Delete \(golfer.name)?", isPresented: $isDeleting) {
                        Button("Yes, delete \(golfer.name)", role: .destructive) {
                            //delete(golfer)
                        }
                    }
                       } else {
                    ContentUnavailableView("Select a golfer",
                                           systemImage: "person.and.background.dotted")
        }
    }
    private func delete(_ golfer: Golfer) {
        navigationContext.selectedGolfer = nil
        modelContext.delete(golfer)
    }
}

private struct GolferDetailContentView: View {
    let golfer: Golfer
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Name")
                    Spacer()
                    Text("\(golfer.name)")
                }
                HStack {
                    Text("Tagline")
                    Spacer()
                    Text("\(golfer.tagline)")
                }
                HStack {
                    Text("Favorite Course")
                    Spacer()
                    Text("\(golfer.favoriteCourse)")
                }
                HStack {
                    Text("Stance")
                }
            }
        }
    }
}

//#Preview {
//    ModelContainerPreview(ModelContainer.sample) {
//        GolferDetailView(golfer: .anon)
//            .environment(NavigationContext())
//    }
//}
