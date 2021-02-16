//
//  ContentView.swift
//  Gradients
//
//  Created by Peter Victoratos on 1/10/21.
//

import SwiftUI
import ComposableArchitecture

struct ImageView: View {
    var body: some View {
        ZStack {
            Image(uiImage: UIImage(named: "zz")!)
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
            AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue, Color.green]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, startAngle: .zero, endAngle: Angle(degrees: 180))
                .frame(width: 300, height: 300, alignment: .center)
                .opacity(0.5)
                .blendMode(.saturation)
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        AppView(store: Store(
            initialState: AppState(),
            reducer: appReducer,
            environment: AppEnvironment(
                mainQueue: DispatchQueue.main.eraseToAnyScheduler(),
                numberFact: { number in Effect(value: "\(number) is a good number Pete") } )
        )
        )
    }
}

struct AppView: View {
    let store: Store<AppState, AppAction>
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    
    var body: some View {
        WithViewStore(self.store) { viewStore in
            ZStack {
                Color(.black)
            VStack {
                ZStack{
                    Image(systemName: "tornado")
                        .font(.system(size: 50, weight: .bold, design: .default))
                        .modifier(ThreeDeeEffect(offset: CGSize(width: -4, height: -3)))
                }
                
                VStack {
                    AngularGradient(gradient: Gradient(colors: colors),
                                    center: UnitPoint(x: 0.50, y: 1.00),
                                    startAngle: Angle(degrees: 180.00),
                                    endAngle: Angle(degrees: Double(360 - viewStore.count)))
                        .frame(width: 100, height: 100)
                    AngularGradient(gradient: Gradient(colors: colors),
                                    center: UnitPoint(x: 0.50, y: 0),
                                    startAngle: Angle(degrees: 0),
                                    endAngle: Angle(degrees: Double(180 - viewStore.count)))
                        .frame(width: 100, height: 100)
                        .offset(x: 0, y: -10.0)
                }
                HStack {
                    Button("-") { viewStore.send(.decrementButtonTapped) }
                    Text("\(viewStore.count)").foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                    Button("+") { viewStore.send(.incrementButtonTapped)}
                }
                
                //i want this button to start a cycle from 0-180 back down to 0,
                    //it changes every .25 seconds, and it disables the button
                    //until it ends?
                Button(action: { viewStore.send(.numberFactButtonTapped)}) {
                    HStack {
                        Image(systemName: "play")
                        Text("Animate!")
                    }
                }.buttonStyle(ThreeDeeButtonStyle())
            }
            .alert(
                item: viewStore.binding(
                    get: { $0.numberFactAlert.map(FactAlert.init(title:)) },
                    send: .factAlertDismissed
                ),
                content: { Alert(title: Text($0.title)) }
            )
        }
    }
}
}

struct FactAlert: Identifiable {
    var title: String
    var id: String { self.title }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//State: A type that describes the data your feature needs to perform its logic & render UI
struct AppState: Equatable {
    var count = 0
    var numberFactAlert: String?
}

//Action: A type that represents all of the actions that can happen in your feature, such as user actions,
//notifications, event sources and more
enum AppAction: Equatable {
    case factAlertDismissed
    case decrementButtonTapped
    case incrementButtonTapped
    case numberFactButtonTapped
    case numberFactResponse(Result<String, ApiError>)
    case animateButtonTapped
}

struct ApiError: Error, Equatable {}

//Environment: A type that holds any dependancies the feature needs, such as API clients, analytics clients, etc
struct AppEnvironment {
    var mainQueue: AnySchedulerOf<DispatchQueue>
    var numberFact: (Int) -> Effect<String, ApiError>
}

//Reducer: A function that describes how to evolve the current state of the app to the next state given an action.
//The reducer is also responsible for returning any effects that should be run, such as API requests, which can
//be done by returning an Effect value
let appReducer = Reducer<AppState, AppAction, AppEnvironment> { state, action, environment in
    switch action {
    case .factAlertDismissed:
        state.numberFactAlert = nil
        return .none
        
    case .decrementButtonTapped:
        state.count -= 1
        return .none
        
    case .incrementButtonTapped:
        state.count += 1
        return .none
        
    case .numberFactButtonTapped:
        return environment.numberFact(state.count)
            .receive(on: environment.mainQueue)
            .catchToEffect()
            .map(AppAction.numberFactResponse)
        
    case let .numberFactResponse(.success(fact)):
        state.numberFactAlert = fact
        return .none
        
    case .numberFactResponse(.failure):
        state.numberFactAlert = "Could not load a number fact :("
        return .none
        
    case .animateButtonTapped:
        //start a timer that adds one to state.count ever .01 seconds
        let t = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            state.count += 1
        }
        return .none
    }
}

//Store: The runtime that actually drives your feature. You send all user actions to the store so that the store can
//run the reducer and effects, and you can observe state chagnes in the store so that you can update UI.

struct ThreeDeeEffect: ViewModifier {
    let offset: CGSize
    
    func negOffset() -> CGSize {
        return CGSize(width: -self.offset.width, height: -self.offset.height)
    }
    
    func body(content: Content) -> some View {
        content
            .offset(self.negOffset())
            .foregroundColor(Color("redbis"))
            .blendMode(.plusLighter)
            .overlay(
                content
                    .foregroundColor(Color("bluebus"))
                    .blendMode(.plusLighter)
                    .offset(self.offset)
            )
    }
}

struct ThreeDeeButtonStyle: ButtonStyle {
    
    func backgroundShift(_ isPressed: Bool)-> CGSize {
        if isPressed {
            return CGSize(width: -4, height: -3)
        }
        else {
            return CGSize()
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .modifier(ThreeDeeEffect(offset: self.backgroundShift(configuration.isPressed)))
            ).scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring())
    }
}
