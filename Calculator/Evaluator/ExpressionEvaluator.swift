//
//  ExpressionEvaluator.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

// MARK - ExpressionEvaluator

protocol ExpressionEvaluator {
    
    associatedtype Token
    
    
    /// Calculate expression
    /// - Parameter expression - expression to calculate
    /// - Throws Evaluator errors, such as invalid syntaxis, if expression can't be evaluated
    /// - Returns: value as Double
    func evaluate(expression: [Token]) throws -> Double
    
}
