// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation
//
// Used the following tutorials:
// https://www.swiftbysundell.com/articles/building-a-command-line-tool-using-the-swift-package-manager/
// https://www.swift.org/getting-started/cli-swiftpm/

import Figlet
import ArgumentParser

@main
struct iChing: ParsableCommand {
    @Option(help: "What sequence of coin faces did you get?")
    public var input: String
    
    //I need this function to be able to take user input and return a hexagram
    //
    
    public func run() throws {
        var sequences = [String]()
        var sequenceCount = 0
        
        while sequenceCount < 6 {
            print("Enter sequence \(sequenceCount + 1) (Up to 3 characters, only 'h' or 't'): ", terminator: "")
            var inputSequence = ""
            
            while true {
                guard let character = readChar() else {
                    continue
                }
                
                if character == "h" || character == "t" {
                    inputSequence.append(character)
                    print(character, terminator: "")
                } else if character == "\n" { // Enter key
                    if inputSequence.isEmpty {
                        print("Sequence cannot be empty.")
                    } else if inputSequence.count > 3 {
                        print("\nSequence should be at most 3 characters long.")
                        inputSequence = ""
                    } else {
                        sequences.append(inputSequence)
                        sequenceCount += 1
                        print("")
                        break
                    }
                } else {
                    print("\nInvalid character. Only 'h' or 't' are allowed.")
                }
            }
        }
        
        print("Sequences entered:")
        for sequence in sequences {
            print(sequence)
        }
        
        func readChar() -> Character? {
            let charMap: [Int: Character] = [
                104: "h", // ASCII code for 'h'
                116: "t", // ASCII code for 't'
                10: "\n"  // ASCII code for Enter key
            ]
            
            guard let input = readLine(strippingNewline: true),
                  let charCode = input.utf8.first,
                  let character = charMap[Int(charCode)]
            else {
                return nil
            }
            
            return character
        }
        
        Figlet.say(self.input)
    }
}
