//
//  EvaluatorError.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

import Foundation

// MARK: - EvaluatorError

enum EvaluatorError: Error {
    case invalidSyntaxis(message: String)
    case noFactorial(number: Double)
}

// MARK: - LocalizedError

extension EvaluatorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidSyntaxis(let message):
            return "Syntaxis error: \(message)"
        case .noFactorial(let number):
            return "Factorial of \(number) is not defined"
        }
    }
}
