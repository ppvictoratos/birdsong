//
//  Simulation.swift
//  SwiftUIGameOfLife
//
//  Created by Van Simmons on 5/31/20.
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//
import ComposableArchitecture
import Combine
import Dispatch
import Grid
import GameOfLife

public struct SimulationState {
    public var gridState = GridState()
    public var isRunningTimer = false

    public init(gridState: GridState = GridState()) {
        self.gridState = gridState
    }
}

extension SimulationState: Equatable { }

extension SimulationState: Codable { }

public extension SimulationState {
    enum Action: Equatable {
        case none
        case update(grid: Grid)
        case grid(action: GridState.Action)
        case resetGridToEmpty
        case resetGridToRandom
        case tick
        case startTimer
    }
    
    enum Identifiers: Hashable {
        case simulationTimer
        case simulationCancellable
    }
}

public struct SimulationEnvironment {
    var scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler()
    var gridEnvironment = GridEnvironment()
    var timerEffectCancellable: AnyCancellable? = .none
    
    public init(
        scheduler: AnySchedulerOf<DispatchQueue> = DispatchQueue.main.eraseToAnyScheduler(),
        gridEnvironment: GridEnvironment = GridEnvironment()
    ) {
        self.scheduler = scheduler
        self.gridEnvironment = gridEnvironment
    }
}

public let simulationReducer = Reducer<SimulationState, SimulationState.Action, SimulationEnvironment>.combine(
    Reducer<SimulationState, SimulationState.Action, SimulationEnvironment>{ state, action, env in
        switch action {
            case .none:
                return .none
            case .update(grid: let grid):
                state.gridState.grid = grid
                return .none
            case .grid(action:):
                return .none
            case .resetGridToEmpty:
                state.gridState.grid = Grid(10, 10, Grid.Initializers.empty)
                return .none
            case .resetGridToRandom: //assuming there is a typo in my version of Problem 4
                state.gridState.grid = Grid(10, 10, Grid.Initializers.random)
                return .none
            case .tick:
                state.gridState.ticks += 1
                state.gridState.grid = state.gridState.grid.next
                return .none
            case .startTimer:
                state.isRunningTimer = true
                Effect.timer(id: SimulationState.Identifiers.simulationCancellable,
                                       every: 1, on: env.scheduler)
                return .none
        }
    }
)
