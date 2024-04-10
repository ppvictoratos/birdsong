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
struct FigletTool: ParsableCommand {
    @Option(help: "What text would you like to see in a larger font?")
    public var input: String
    
    public func run() throws {
        Figlet.say(self.input)
    }
}
