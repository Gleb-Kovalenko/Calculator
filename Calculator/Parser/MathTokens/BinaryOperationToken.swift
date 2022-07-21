//
//  BinaryOperationToken.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

import Foundation

// MARK: - BinaryOperation

enum BinaryOperation: Character, Equatable {
    case addition = "+"
    case substraction = "-"
    case multiply = "*"
    case division = "/"
    case power = "^"
    
    var priority: Int {
        switch self {
        case .addition, .substraction: return 0
        case .multiply, .division: return 1
        case .power: return 2
        }
    }
    
    func doOperation(firstNumber: Double, secondNumber: Double) -> Double {
        switch self {
        case .addition:
            return firstNumber + secondNumber
        case .substraction:
            return firstNumber - secondNumber
        case .division:
            return firstNumber / secondNumber
        case .multiply:
            return firstNumber * secondNumber
        case .power:
            return pow(firstNumber, secondNumber)
        }
    }
}
