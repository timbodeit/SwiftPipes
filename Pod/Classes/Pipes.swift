//
//  Pipe.swift
//  SwiftPipes
//
//  Created by Tim Bodeit on 06/10/2015
//
//

import Foundation
import Swift

precedencegroup LeftPipePrecedence {
  associativity: right
  higherThan: NilCoalescingPrecedence
  lowerThan: RangeFormationPrecedence
}

precedencegroup RightPipePrecedence {
  associativity: left
  higherThan: NilCoalescingPrecedence
  lowerThan: RangeFormationPrecedence
}

infix operator ..   : LeftPipePrecedence
infix operator <|   : LeftPipePrecedence
infix operator |>   : RightPipePrecedence
infix operator |?>  : RightPipePrecedence
infix operator |??> : RightPipePrecedence
infix operator |?   : RightPipePrecedence

/**
Function composition.

For a parameter x:
`lhs(rhs(x))` == `(lhs .. rhs)(x)`
*/
public func .. <A,B,C>(lhs: @escaping (B)->C, rhs: @escaping (A)->B) -> (A)->C {
    return { a in
        lhs(rhs(a))
    }
}

/**
Pipe the input on the right into the function on the left.

Chainable:
`f <| g <| h <| x` == `f(g(h(x)`
*/
public func <| <A, B>(lhs: (A) -> B, rhs: A) -> B {
    return lhs(rhs)
}

/**
Pipe the input on the left into the function on the right.

Chainable:
`x |> f |> g |> h` == `h(g(f(x)))`
*/
public func |> <A, B>(lhs: A, rhs: (A) -> B) -> B {
    return rhs(lhs)
}

/**
Try piping the optional input into the function on the right.

Result is nil if lhs is nil. Otherwise, same as `|>`
*/
public func |?> <A, B>(lhs: A?, rhs: (A) -> B) -> B? {
  return lhs.map(rhs)
}

/**
Try piping the optional input into the function on the right.

Result is nil if lhs is nil. Otherwise, same as `rhs(lhs!)`.
*/
public func |??><A, B>(lhs: A?, rhs: (A) -> B?) -> B? {
  return lhs.flatMap(rhs)
}

/**
Try piping the optional input into the side-effecting function on the right.

Result is the input value.

Equivalence: `a |? f` === `a |?> { a in f(a); return a }`
*/
public func |?<A>(lhs: A?, rhs: (A) -> ()) -> A? {
  return lhs |?> { a in rhs(a); return a }
}
