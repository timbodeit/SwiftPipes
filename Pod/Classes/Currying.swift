//
//  Currying.swift
//  SwiftPipes
//
//  Created by Tim Bodeit on 07/10/15.
//
//

import Foundation

/// Curried version of map on Sequence Types
public func map<S: SequenceType, T>(transform: (S.Generator.Element -> T)) -> S -> [T] {
    return { source in
        source.map(transform)
    }
}

/// Curried version of flatMap on Sequence Types
public func flatMap<S: SequenceType, T>(transform: (S.Generator.Element -> [T])) -> S -> [T] {
    return { source in
      source.flatMap(transform)
    }
}

/// Curried version of map on Optionals
public func map<S, T>(transform: (S -> T)) -> S? -> T? {
    return { source in
        source.map(transform)
    }
}

/// Curried version of flatMap on Optionals
public func flatMap<S, T>(transform: (S -> T?)) -> S? -> T? {
    return { source in
        source.flatMap(transform)
    }
}
