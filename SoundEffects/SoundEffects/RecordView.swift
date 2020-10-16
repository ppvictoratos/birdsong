//
//  RecordView.swift
//  SoundEffects
//
//  Created by Peter Victoratos on 10/15/20.
//

import SwiftUI
import ComposableArchitecture
//import Audio package

struct RecordView: View {
    let store: Store<AudioState, AudioState.Action>
    
    public init(store: Store<AudioState, AudioState.Action>) {
        self.store = store
    }
    
    var body: some View {
        buttonStack(self.store)
    }
    
    func buttonStack(_ store: Store<AudioState, AudioState.Action>) -> some View {
        WithViewStore(store) { viewStore in
            recordButton(viewStore, title: "Record!",
                              action: .record)
        }
    }

    func recordButton(
        _ viewStore: ViewStore<AudioState, AudioState.Action>,
        title: String,
        action: AudioState.Action) -> some View {
        Button(action: { viewStore.send(action) }) {
            Text(title)
                .font(.system(size: 12.0))
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                .foregroundColor(.black)
        }
    }
}

public struct recordPreview: PreviewProvider {
    static let previewState = AudioState()
    public static var previews: some View {
        RecordView(store: Store(initialState: previewState, reducer: audioReducer, environment: AudioEnvironment()))
    }
}
