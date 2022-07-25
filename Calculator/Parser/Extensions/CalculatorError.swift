//
//  CalculatorError.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 25.07.2022.
//

import Foundation

// MARK: - CalculatorError

enum CalculatorError: Error {
    case noCalculatorInstance
}

// MARK: - LocalizedError

extension CalculatorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .noCalculatorInstance:
            return "Calculator object not declared"
        }
    }
}
