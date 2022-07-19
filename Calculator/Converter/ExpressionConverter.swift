//
//  ExpressionConverter.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

// MARK - ExpressionConverter

protocol ExpressionConverter {
    
    associatedtype Token: Equatable
    
    /// Convert received subsequence in something new subsequence
    /// - Parameter expression - subsequence to convert
    /// - Throws Converter errors, such as inconsistent brackets
    /// - Returns: new subsequence
    /// Example: Parsed string in RPN string
    func convert(expression: [Token]) throws -> [Token]
}
