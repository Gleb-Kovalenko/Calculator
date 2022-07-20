//
//  EvaluatorError.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

import Foundation

// MARK - EvaluatorError

enum EvaluatorError: Error {
    case invalidSyntaxis
}

// MARK - LocalizedError

extension EvaluatorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidSyntaxis:
            return "Invalid syntaxis error"
        }
    }
}
