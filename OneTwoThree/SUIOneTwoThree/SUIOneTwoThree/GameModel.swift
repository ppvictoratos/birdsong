//
//  GameModel.swift
//  SUIOneTwoThree
//
//  Created by Zachary Lahey on 10/16/21.
//  Copyright © 2021 loveshakk. All rights reserved.
//

import Foundation

//this is where we deal with all game logic

//we should store the hard coded examples in here

class GameModel {
    
    let initialValue = 0
    var total = 0
    var initialMode = "Addition"
    var mode = "Addition"
    var userAnswer = 0
    var userScore = 0
    var secondNum = 0
    var difficulty = "Easy"
    var tempNum = 0
    
    init() {
    }
    //Resets game
    func reset(){
        total = initialValue
        mode = initialMode
    }
    //Calculates addition
    func addBy() {
        total = total + secondNum
    }
    //Calculates subtraction
    func subtractBy() {
        total = total - secondNum
    }
    //Calculates multiplication
    func multiplyBy() {
        total = total * secondNum
    }
    //Calculates division
    func divideBy() {
        total = total / secondNum
    }
    //Sets answer for problem
    func setValue(number: Int){
        total = number
    }
    //Sets +, /, *, - mode
    func setMode(gameOperator: String){
        mode = gameOperator
    }
    //Sets difficulty level
    func setDifficulty(diff: String){
        difficulty = diff
    }
    //Gets correct total
    func getValue() -> Int {
        return total
    }
    //Creates problem based on difficulty
    func createProblem(){
        if(difficulty == "Easy"){
            if(mode == "Addition"){
                total = Int.random(in: 1 ... 9)
                secondNum = Int.random(in: 1 ... 9)
            }
            if(mode == "Subtraction"){
                total = Int.random(in: 1 ... 9)
                secondNum = Int.random(in: 1 ... 9)
                if(secondNum > total){
                    tempNum = total
                    total = secondNum
                    secondNum = tempNum
                }
            }
            if(mode == "Multiplication"){
                total = Int.random(in: 1 ... 9)
                secondNum = Int.random(in: 1 ... 9)
            }
            if(mode == "Division"){
                total = Int.random(in: 1 ... 9)
                secondNum = Int.random(in: 1 ... 9)
                total = total * secondNum
            }
        }
        if(difficulty == "Medium"){
            if(mode == "Addition"){
                total = Int.random(in: 1 ... 30)
                secondNum = Int.random(in: 1 ... 30)
            }
            if(mode == "Subtraction"){
                total = Int.random(in: 1 ... 30)
                secondNum = Int.random(in: 1 ... 30)
                if(secondNum > total){
                    tempNum = total
                    total = secondNum
                    secondNum = tempNum
                }
            }
            if(mode == "Multiplication"){
                total = Int.random(in: 1 ... 12)
                secondNum = Int.random(in: 1 ... 12)
            }
            if(mode == "Division"){
                total = Int.random(in: 1 ... 12)
                secondNum = Int.random(in: 1 ... 12)
                total = total * secondNum
            }
        }
        if(difficulty == "Hard"){
            if(mode == "Addition"){
                total = Int.random(in: 1 ... 200)
                secondNum = Int.random(in: 1 ... 200)
            }
            if(mode == "Subtraction"){
                total = Int.random(in: 1 ... 200)
                secondNum = Int.random(in: 1 ... 200)
                if(secondNum > total){
                    tempNum = total
                    total = secondNum
                    secondNum = tempNum
                }
            }
            if(mode == "Multiplication"){
                total = Int.random(in: 1 ... 15)
                secondNum = Int.random(in: 1 ... 15)
            }
            if(mode == "Division"){
                total = Int.random(in: 1 ... 15)
                secondNum = Int.random(in: 1 ... 15)
                total = total * secondNum
            }
        }
    }
    
    func setUserAnswer(number: Int){
        userAnswer = number
    }
    func answerCorrect() -> Bool {
        return (userAnswer == total)
    }
    func sendScore() -> Int{
        return userScore
    }
    
    //Counts number of digits in number
    func digitCount(number: Int) -> Int{
        
        var numberOfDigits = 1
        if (number >= 10000) {
            numberOfDigits += 4
            return numberOfDigits
        }
        
        if (number >= 1000) {
            numberOfDigits += 3
            return numberOfDigits
        }
        
        if (number >= 100) {
            numberOfDigits += 2
            return numberOfDigits
        }
        
        if (number >= 10) {
            numberOfDigits += 1
            return numberOfDigits
        }
        return numberOfDigits
    }
    
    //Function converts numbers into words
    func getWordValue(number: Int) -> String {
        
        var numberOfDigits = digitCount(number: number)
        var num = number
        var word = ""
        var temp = 0
        
        if (numberOfDigits == 0){
            word = "No Number"
            return word
        }
        
        if (numberOfDigits > 3){
            word = "Length more than 4"
            return word
        }
        
        let singleDigits: [String] = ["Zero", "One", "Two", "Three", "Four", "Five", "Six", "Seven",  "Eight", "Nine"]
        
        let twoDigits: [String] = ["Ten", "Eleven", "Twelve",  "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen",  "Nineteen"]
        
        let tensMultiple: [String] = ["", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty",  "Ninety"]
        
        let tensPower: [String] = ["Hundred"]
        
        while (numberOfDigits > 0){
            
            if(numberOfDigits == 3){
                temp = num/100
                word += singleDigits[temp] + " "
                word += tensPower[0] + " "
                num = num%100
            }
            if(numberOfDigits == 2){
                if ((number >= 10) && (number < 20)){
                    temp = num%10
                    word += twoDigits[temp] + " "
                    numberOfDigits = numberOfDigits-2
                }
                else{
                    temp = num/10
                    word += tensMultiple[temp] + " "
                    num = num%10
                }
            }
            if(numberOfDigits == 1){
                word += singleDigits[num]
                num = 0
            }
            
            if (numberOfDigits == 0){
                numberOfDigits = numberOfDigits - numberOfDigits
            }
            else if (numberOfDigits != 0){
                numberOfDigits = numberOfDigits - 1
            }
        }
        return word
    }
}

