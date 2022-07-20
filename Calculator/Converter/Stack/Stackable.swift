//
//  Stackable.swift
//  Calculator
//
//  Created by Глеб Коваленко on 18.07.2022.
//

// MARK - Stackable

protocol Stackable {
    
    associatedtype Token
    
    func peek() -> Token?
    mutating func push(_ element: Token)
    @discardableResult mutating func pop() -> Token?
}

// MARK - Stackable

extension Stackable {
    var isEmpty: Bool { peek() == nil }
}
