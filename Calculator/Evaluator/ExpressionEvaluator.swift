//
//  ExpressionEvaluator.swift
//  Calculator
//
//  Created by Глеб Коваленко on 18.07.2022.
//

// MARK - ExpressionEvaluator

protocol ExpressionEvaluator {
    
    associatedtype Token
    
    func evaluate(expression: [Token]) throws -> Double
}
