//
//  ExtensionLocalizedError.swift
//  Calculator
//
//  Created by Глеб Коваленко on 17.07.2022.
//

import Foundation

// MARK - LocalizedError

extension ParseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .oneMoreDot:
            return "Error: Some number has more than one dot"
        case .unknownFunction:
            return "Error: No match with some function"
        case .unknownOperation:
            return "Error: No match with some operation"
        }
    }
}
