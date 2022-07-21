//
//  PostfixUnaryOperation.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 21.07.2022.
//

// MARK - PostfixUnaryOperation

enum PostfixUnaryOperation: Character, Equatable {
    case factorial = "!"
    
    func doOperation(number: Double) throws -> Double {
        switch self {
        case .factorial:
            if let factorial = number.factorial() {
                return factorial
            } else {
                throw EvaluatorError.noFactorial(number: number)
            }
        }
    }
}
