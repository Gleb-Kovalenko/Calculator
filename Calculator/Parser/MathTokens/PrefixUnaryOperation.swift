//
//  PrefixUnaryOperation.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 21.07.2022.
//

import Foundation

// MARK: - PrefixUnaryOperation

enum PrefixUnaryOperation: Character, Equatable {
    
    case negative = "-"
    case squart = "√"
    
    func perform(to number: Double) -> Double {
        switch self {
        case .negative:
            return -number
        case .squart:
            return sqrt(number)
        }
    }
}
