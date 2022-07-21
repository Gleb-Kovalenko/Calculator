//
//  PrefixUnaryOperation.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 21.07.2022.
//

// MARK - PrefixUnaryOperation

enum PrefixUnaryOperation: Character, Equatable {
    case negative = "-"
    
    func doOperation(number: Double) -> Double {
        switch self {
        case .negative:
            return -number
        }
    }
}
