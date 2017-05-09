//
//  Flip.swift
//  SwiftPipes
//
//  Created by Tim Bodeit on 07/10/15.
//
//

import Foundation

/**
Flip the first two arguments of a curried function

Function of type `A -> B -> C` becomes `B -> A -> C`
*/
public func flip<S, T, U>(_ inputFunction: @escaping ((S) -> (T) -> U)) -> (T) -> (S) -> U {
    return { (t: T) -> ((S) -> U) in
        return { (s: S) -> U in
            return inputFunction(s)(t)
        }
    }
}
