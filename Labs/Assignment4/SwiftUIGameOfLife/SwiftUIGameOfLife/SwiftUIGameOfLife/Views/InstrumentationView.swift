//
//  InstrumentationView.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 7/11/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
//
//  InstrumentationView.swift
//  GameOfLife
//
//  Created by Van Simmons on 9/12/19.
//  Copyright © 2019 Van Simmons. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import Simulation
import FunctionalProgramming

fileprivate let formatter: NumberFormatter = {
    let nf = NumberFormatter()
    nf.numberStyle = .decimal
    nf.maximumFractionDigits = 3
    return nf
}()

struct InstrumentationView: View {
    let store: Store<SimulationState, SimulationState.Action>
    private var width: CGFloat

    init(
        store: Store<SimulationState, SimulationState.Action>,
        width: CGFloat = 250.0
    ) {
        self.store = store
        self.width = width
    }

    var body: some View {
        VStack {
            Spacer()
            control1(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control2(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control3(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            control4(width)
                .frame(width: width, alignment: .leading)
                .offset(x: 0.0)
                .fixedSize(horizontal: true, vertical: false)
            buttons
                .frame(width: width, alignment: .top)
                .fixedSize(horizontal: true, vertical: false)
                .padding(.top, 16.0)
            Spacer()
        }
    }

    func control1(_ width: CGFloat) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 6 code replaces the following line
                //need to go deeper into the viewstore?
                Text(verbatim: "Size \(viewStore)").font(.title).fontWeight(.black).foregroundColor(Color("accent"))
                Spacer()
                Text(verbatim: "Depth").font(.title).fontWeight(.black).foregroundColor(Color("accent"))
            }
        }
    }

    func control2(_ width: CGFloat) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 7 code replaces the following line
                Slider() //obtain value from a viewStore binding with get of the # of rows ni the grid and set of the setGridSize action
                                        //slide over 5 - 40, step size 1
                        //void for onEditingChange
                        //min Val label 5, max val label 40
                Spacer()
                Text(verbatim: /(self.cycleLength(for:)))
            }
        }
    }

    func control3(_ width: CGFloat) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 8 code replaces the following line
                EmptyView()
            }
        }
    }

    func control4(_ width: CGFloat) -> some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 9 code replaces the following line
                EmptyView()
            }
        }
    }

    var buttons: some View {
        WithViewStore(store) { viewStore in
            HStack {
                // Your Problem 10 code replaces the following line
                EmptyView()
            }
        }
    }

    func cycleLength(for viewStore: ViewStore<SimulationState, SimulationState.Action>) -> String {
        guard let cycleLength = viewStore.gridState.history.cycleLength else { return "" }
        return "\(cycleLength)"
    }

    func numberString(for value: Double) -> String {
        "\(formatter.string(from: NSNumber(value: value) ) ?? "")"
    }
}

struct InstrumentationView_Previews: PreviewProvider {
    static let previewState = SimulationState()
    public static var previews: some View {
        InstrumentationView(
            store: Store(
                initialState: previewState,
                reducer: simulationReducer,
                environment: SimulationEnvironment()
            )
        )
    }
}
