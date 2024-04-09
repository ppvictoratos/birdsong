// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation
//
// Used the following tutorial:
// https://www.swiftbysundell.com/articles/building-a-command-line-tool-using-the-swift-package-manager/

import ArgumentParser

@main
struct iChing_CLT: ParsableCommand {    
    mutating func run() throws {
        print("hello, world!")
    }
}
