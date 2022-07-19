//
//  ExpressionConverter.swift
//  Calculator
//
//  Created by Глеб Коваленко on 18.07.2022.
//

// MARK - ExpressionConverter

protocol ExpressionConverter {
    
    associatedtype Token: Equatable
    
    /// Convert received subsequence in something new subsequence
    /// expression - subsequence to convert
    /// - Returns: new subsequence
    /// Example: Parsed string in RPN string
    func convert(expression: [Token]) throws -> [Token]
}
