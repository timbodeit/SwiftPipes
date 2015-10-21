//
//  Pipe.swift
//  SwiftPipes
//
//  Created by Tim Bodeit on 06/10/2015
//
//

import Foundation

infix operator ..   { precedence 50 associativity right }
infix operator <|   { precedence 50 associativity right }
infix operator |>   { precedence 50 associativity left  }
infix operator |?>  { precedence 50 associativity left  }
infix operator |??> { precedence 50 associativity left  }

/**
Function composition.

For a parameter x:
`lhs(rhs(x))` == `(lhs .. rhs)(x)`
*/
public func .. <A,B,C>(lhs: B->C, rhs: A->B) -> A->C {
    return { a in
        lhs(rhs(a))
    }
}

/**
Pipe the input on the right into the function on the left.

Chainable:
`f <| g <| h <| x` == `f(g(h(x)`
*/
public func <| <A, B>(lhs: A -> B, rhs: A) -> B {
    return lhs(rhs)
}

/**
Pipe the input on the left into the function on the right.

Chainable:
`x |> f |> g |> h` == `h(g(f(x)))`
*/
public func |> <A, B>(lhs: A, rhs: A -> B) -> B {
    return rhs(lhs)
}

/**
Try piping the optional input into the function on the right.

Result is nil if lhs is nil. Otherwise, same as `|>`
*/
public func |?> <A, B>(lhs: A?, rhs: A -> B) -> B? {
    return lhs
        |> map { rhs($0) }
}

/**
Try piping the optional input into the function on the right.

Result is nil if lhs is nil. Otherwise, same as `rhs(lhs!)`.
*/
public func |??><A, B>(lhs: A?, rhs: A -> B?) -> B? {
  return lhs |> flatMap { rhs($0) }
}
