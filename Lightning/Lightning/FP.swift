//
//  FP.swift
//  Lightning
//
//  Created by Peter Victoratos on 12/9/20.
//

import Foundation

precedencegroup CompositionPrecedence {
  associativity: right
  higherThan: AssignmentPrecedence
  lowerThan: MultiplicationPrecedence, AdditionPrecedence
}

public func apply <A, B>(_ a: A, _ f: @escaping (A) -> B) -> B {
    f(a)
}

infix operator |>: CompositionPrecedence
public func |> <A, B>(_ a: A, _ f: @escaping (A) -> B) -> B {
    apply(a, f)
}

public func compose <A, B, C>(
    _ f: @escaping (A) -> B,
    _ g: @escaping (B) -> C
) -> (A) -> C {
    { a in g(f(a)) }
}

infix operator >>>: CompositionPrecedence
public func >>> <A, B, C>(
    f: @escaping (A) -> B,
    g: @escaping (B) -> C
) -> (A) -> C {
    compose(f, g)
}

//public protocol VectorArithmetic : AdditiveArithmetic {
//
//    /// Multiplies each component of this value by the given value.
//    mutating func scale(by rhs: Double)
//
//    /// Returns the dot-product of this vector arithmetic instance with itself.
//    var magnitudeSquared: Double { get }
//}

var values: [Double] = [1.0, 2.0, 3.0, 4.0, 5.0, 3.0]

func computePF() -> Double {
    var sum: Double = 0.0
    _ = values.map { sum += $0 * $0 }
    return sum
}

func computePFR() -> Double {
    return values.reduce(Double(0), { result, element in result + element * element})
}

