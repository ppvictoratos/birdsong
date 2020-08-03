//
//  ConfigurationView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import SwiftUI
import ComposableArchitecture
import Configurations
import Configuration

public struct ConfigurationsView: View {
    let store: Store<ConfigurationsState, ConfigurationsState.Action>
    let viewStore: ViewStore<ConfigurationsState, ConfigurationsState.Action>

    public init(store: Store<ConfigurationsState, ConfigurationsState.Action>) {
        self.store = store
        self.viewStore = ViewStore(store, removeDuplicates: ==)
    }
    
    public var body: some View {
        // Your problem 3A code starts here.
        VStack {
            List {
                ForEachStore(
                    self.store.scope(
                        state: \.configs,
                        action: ConfigurationsState.Action.configuration(index:action:)
                    ),
                    content: ConfigurationView.init(store:)
                )
            }
            
            Divider()
                .padding(8.0)
            
            HStack {
                Spacer()
                Button(action: {
                    self.viewStore.send(.fetch)
                }) {
                    Text("Fetch").font(.system(size: 24.0))
                }
                .padding([.top, .bottom], 8.0)
                
                Spacer()
                
                Button(action: {
                    self.viewStore.send(.clear)
                }) {
                    Text("Clear").font(.system(size: 24.0))
                }
                .padding([.top, .bottom], 8.0)
                
                Spacer()
            }
            .padding([.top, .bottom], 8.0)
        }
        // Problem 5a goes here
        // Problem 3B begins here
        // Problem 5b Goes here
        // Problem 3A ends here
    }
}

public struct ConfigurationsView_Previews: PreviewProvider {
    static let previewState = ConfigurationsState()
    public static var previews: some View {
        ConfigurationsView(
            store: Store(
                initialState: previewState,
                reducer: configurationsReducer,
                environment: ConfigurationsEnvironment()
            )
        )
    }
}
