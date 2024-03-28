//
//  MainMenu.swift
//  SUIOneTwoThree
//
//  Created by Peter Victoratos on 6/17/20.
//  Copyright © 2020 loveshakk. All rights reserved.
//

import SwiftUI

enum gameMode {
    case addition      //0
    case subtraction   //1
    case multiplication//2
    case division      //3
}

//have a global state that changes the game mode
//for now have each button mutate the state

struct MainMenu: View {
    @State var gameModeRef: gameMode
    let chalk = Font.custom("Chalkduster", size: 45)
    
    var body: some View {
        NavigationView{
        ZStack{
            Image("green").resizable().edgesIgnoringSafeArea(.all)
        VStack{
            Text("OneTwoThree").font(chalk).bold().foregroundColor(.white)
                    Spacer(minLength: 30)
                    VStack {
                        Spacer()
                    HStack{
                        Spacer()
                        Button(action: {self.gameModeRef = gameMode.addition}){
                            Text("+").font(chalk).accentColor(.white)
                        }
                        Spacer()
                        Button(action: {self.gameModeRef = gameMode.subtraction}){
                            Text("-").font(chalk).accentColor(.white)
                        }
                        Spacer()
                    }
                        Spacer(minLength: 15)
                    HStack{
                        Spacer()
                        Button(action: {self.gameModeRef = gameMode.multiplication}){
                            Text("x").font(chalk).accentColor(.white)
                        }
                        Spacer()
                        Button(action: {self.gameModeRef = gameMode.division}){
                            Text("÷").font(chalk).accentColor(.white)
                        }
                        Spacer()
                    }
                        Spacer()
                }
                    Spacer(minLength: 30)
            NavigationLink(destination: GameView(self.gameModeRef)){
                Text("Go").font(chalk).accentColor(.white)
                        }
                    Spacer(minLength: 60)
            NavigationLink(destination: UserView()){
                Image(systemName: "person.fill").accentColor(.white)
            }
                    }
            }
    }
    }
    }

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(gameModeRef: gameMode.addition)
    }
}
