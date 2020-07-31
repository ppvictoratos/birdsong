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
        case stopTimer
        case reset
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

//struct GlobalSAE {
//    var simulationState = SimulationState.init()
//    var simulationEnvironment = SimulationEnvironment.init()
//}

//1. SimulationState.gridState
//2. SimulationState.Action.grid(action:)
//3. SimulationEnvironment.gridEnvironment

//this is higher order functions, pullback transforms an existing reducer function into another kind of reducer function by composing three additional functions with the existing one.

public let simulationReducer = Reducer<SimulationState, SimulationState.Action, SimulationEnvironment>.combine(
    Reducer<SimulationState, SimulationState.Action, SimulationEnvironment> { state, action, env in
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
                return Effect.timer(id: SimulationState.Identifiers.simulationCancellable,
                every: 1, on: env.scheduler).map { _ in .tick }
            case .stopTimer:
                state.isRunningTimer = false
                return Effect.cancel(id: SimulationState.Identifiers.simulationCancellable)
            case .reset:
                state.gridState.ticks = 0
                return .none
        }
    }.pullback(state: <#T##WritableKeyPath<GlobalState, SimulationState>#>, action: <#T##CasePath<GlobalAction, SimulationState.Action>#>, environment: <#T##(GlobalEnvironment) -> SimulationEnvironment#>)
)

//okay so here's what im thinking about problem 13.. the example that we have in the ApplicatoinModel class is that we created an AppState strcut that holds all of the global states adn the pullback to the bigger appstate was done within its declaration by throwing the other reducers in there. I can create another appstate but i feel like that's overkill.. It is connected to the SimulationState / SimulationEnvironment already but I feel like its not working because it was declared locally and not globally. How does one work around this? These keypaths are not something I jive with.
//Am I supposed to call onto another class to get the global state (ie: ApplicationModel)? Since this is all in the ApplicationModel I would think not..
//okay so the pullback definetly goes where I have it.. I dont understand how keypaths work

//WritableKeyPath has a root and a value.. In this case the root is the GlobalState and SimState is the value
//CasePath has

// \ keypath (works on structs)
// / case path (works on enums)

//state: WritableKeyPath<GlobalState, SimulationState>
//action: CasePath<GlobalAction, SimulationState.Action>
//environment: (GlobalEnvironment) -> SimulationEnvironment
