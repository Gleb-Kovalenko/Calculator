//
//  ParseError.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

import Foundation

// MARK - ParseError

enum ParseError: Error {
    case oneMoreDot
    case unknownFunction(function: String)
    case unknownOperation(operation: Character)
}

// MARK - LocalizedError

extension ParseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .oneMoreDot:
            return "Some number has more than one dot"
        case .unknownFunction(let function):
            return "Unknown function: \(function)"
        case .unknownOperation(let operation):
            return "Unknown operation: \(operation)"
        }
    }
}
