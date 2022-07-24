//
//  ExpressionEvaluator.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

// MARK: - ExpressionEvaluator

protocol ExpressionEvaluator {
    
    associatedtype Token
    
    /// Calculate expression
    /// - Parameter expression: expression to calculate
    /// - Throws: evaluator errors, such as invalid syntaxis, or when expression can't be evaluated
    /// - Returns: calculated value
    func evaluate(expression: [Token]) throws -> Double
}
