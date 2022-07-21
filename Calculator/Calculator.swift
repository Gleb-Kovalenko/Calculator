//
//  Calculator.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 20.07.2022.
//

import Foundation

// MARK: - Calculator

protocol Calculator {
    
    /// Calculate expression
    /// - Parameter expression: expression to calculate
    /// - Throws: evaluator errors, such as invalid syntaxis, or when expression can't be evaluated
    /// - Returns: value as Double
    func calculate(expression: String) throws -> Double
}
