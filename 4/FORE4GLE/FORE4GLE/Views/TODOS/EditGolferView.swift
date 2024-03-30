//
//  EditGolferView.swift
//  FORE4GLE
//
//  Created by Petie Positivo on 1/27/24.
//

import SwiftUI
import SwiftData

struct EditGolferView: View {
    let golfer: Golfer?
    
    private var EGVviewTitle: String {
        golfer == nil ? "Add Golfer" : "Edit Golfer"
    }
    
    @State private var name = ""
    @State private var tagline = ""
    @State private var favoriteCourse = ""
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                
                TextField("Tagline", text: $tagline)
                
                TextField("Fav Course", text: $favoriteCourse)
                
            }.toolbar {
                ToolbarItem(placement: .principal) {
                    Text(EGVviewTitle)
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let golfer {
                    name = golfer.name
                    tagline = golfer.tagline
                    favoriteCourse = golfer.favoriteCourse
                }
            }
        }
    }
    private func save() {
        if let golfer {
            golfer.name = name
            golfer.tagline = tagline
            golfer.favoriteCourse = favoriteCourse
        } else {
            _ = Golfer(
                name: name,
                tagline: tagline,
                favoriteCourse: favoriteCourse)
        }
    }
}

//#Preview("Add golfer") {
//    ModelContainerPreview(ModelContainer.sample) {
//        EditGolferView(golfer: nil)
//    }
//}
//
//#Preview("Edit golfer") {
//    ModelContainerPreview(ModelContainer.sample) {
//        EditGolferView(golfer: .hennur)
//    }
//}
