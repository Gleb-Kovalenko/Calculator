//
//  Stack.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

import Foundation

// MARK: - Stack

struct Stack<Token> where Token: Equatable {
    
    private var storage = [Token]()
    var isEmpty: Bool {
        peek() == nil
    }
    
    func peek() -> Token? {
        storage.last
    }
    mutating func push(_ token: Token) {
        storage.append(token)
    }
    mutating func pop() -> Token? {
        storage.popLast()
    }
}
