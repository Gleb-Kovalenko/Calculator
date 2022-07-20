//
//  Stack.swift
//  Calculator
//
//  Created by Глеб Коваленко on 18.07.2022.
//

import Foundation

// MARK - Stack

struct Stack<Token>: Stackable where Token: Equatable {
    private var storage = [Token]()
    func peek() -> Token? { storage.last }
    mutating func push(_ token: Token) { storage.append(token)  }
    mutating func pop() -> Token? { storage.popLast() }
}

extension Stack: Equatable {
    static func == (lhs: Stack<Token>, rhs: Stack<Token>) -> Bool { lhs.storage == rhs.storage }
}

extension Stack: CustomStringConvertible {
    var description: String { "\(storage)" }
}
    
extension Stack: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Self.Token...) { storage = elements }
}
