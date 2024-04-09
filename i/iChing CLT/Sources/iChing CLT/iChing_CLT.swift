// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation
//
// Used the following tutorial:
// https://www.swiftbysundell.com/articles/building-a-command-line-tool-using-the-swift-package-manager/

import Figlet
import ArgumentParser

@main
struct FigletTool: ParsableCommand {
    @Option(help: "Specify the input")
    public var input: String
    
    public func run() throws {
        Figlet.say(input)
    }
}
