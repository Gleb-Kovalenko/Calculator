//
//  ConverterError.swift
//  Calculator
//
//  Created by Глеб Коваленко on 18.07.2022.
//

import Foundation

// MARK - ConverterError

enum ConverterError: Error {
    case wrongBrackets
}

// MARK - LocalizedError

extension ConverterError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .wrongBrackets:
            return "Wrong bracket error: Some bracket hasn't a pair"
        }
    }
}
