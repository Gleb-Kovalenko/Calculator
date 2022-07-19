//
//  ExpressionConverter.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

// MARK - ExpressionConverter

protocol ExpressionConverter {
    
    associatedtype Token: Equatable
    
    /// Convert received sequence to new sequence
    /// - Parameter expression: sequence to convert
    /// - Throws: сonverter errors, such as inconsistent brackets
    /// - Returns: new sequence
    /// Example: Parsed string to RPN string
    func convert(expression: [Token]) throws -> [Token]
}
