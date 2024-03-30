//
//  GameView.swift
//  SUIOneTwoThree
//
//  Created by Peter Victoratos on 6/19/20.
//  Copyright © 2020 loveshakk. All rights reserved.
//

import SwiftUI

let chalk = Font.custom("Chalkduster", size: 45)

func gameModeToText(modeRef: gameMode) -> [String] {
    var gameModeStatus: [String] = ["q","p"]
    
    if modeRef == .addition {
        gameModeStatus[0] = "Addition"
        gameModeStatus[1] = "Plus"
    }
    
    if modeRef == .subtraction {
        gameModeStatus[0] = "Subtraction"
        gameModeStatus[1] = "Minus"
    }
    
    if modeRef == .multiplication {
        gameModeStatus[0] = "Multiplication"
        gameModeStatus[1] = "Times"
    }
    
    if modeRef == .division {
        gameModeStatus[0] = "Division"
        gameModeStatus[1] = "Divided by"
    }
    
    return gameModeStatus
}

struct GameView: View {
    @State var gameModeRef: gameMode
    @State var timeRemaining = 10
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var scoreCount = 0
    var gameModel = GameModel()
    var firstNumber = 0
    var secondNumber = 0
    
    init(_ gameModeRef: gameMode) {
        self.gameModeRef = gameModeRef
        self.gameModel.setMode(gameOperator: gameModeToText(modeRef: self.gameModeRef)[0])
        self.gameModel.setDifficulty(diff: "Easy")
        self.gameModel.createProblem()
        self.firstNumber = gameModel.total
        self.secondNumber = gameModel.secondNum

        }
    
    var body: some View {
        
        ZStack{
            Image("green").resizable().edgesIgnoringSafeArea(.all)
        VStack {
        //todo: put this title up top in big font
            Text(gameModeToText(modeRef: gameModeRef)[0]).bold().font(chalk).foregroundColor(.white)
            
            HStack {
                Text(String(scoreCount)).font(chalk).foregroundColor(.white)
                Text("  |  ").font(chalk).foregroundColor(.white)
                Text("\(timeRemaining)").font(Font.monospacedDigit(chalk)()).foregroundColor(.white).onReceive(timer) { _ in
                    if timeRemaining > 0 {
                        timeRemaining -= 1
                    }
                }
            }
            
        Spacer(minLength: 20)
            
        HStack{
            Text(gameModel.getWordValue(number: firstNumber)).font(chalk).foregroundColor(.white)
            Text(gameModeToText(modeRef: gameModeRef)[1]).font(chalk).foregroundColor(.white)
            Text(gameModel.getWordValue(number: secondNumber)).font(chalk).foregroundColor(.white)
            }
            
            UserInputView()
            
        Spacer()
        }
    }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(gameMode.addition)
    }
}
