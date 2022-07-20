//
//  ConverterError.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

import Foundation

// MARK - ConverterError

enum ConverterError: Error {
    case inconsistentBrackets
}

// MARK - LocalizedError

extension ConverterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .inconsistentBrackets:
            return "Inconsistent brackets: Some bracket doesn't have a pair"
        }
    }
}
