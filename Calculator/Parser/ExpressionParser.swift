//
//  ExpressionParser.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

// MARK - ExpressionParser

protocol ExpressionParser {
    
    associatedtype Token
    
    
    /// Parse string to array of something tokens
    /// expression - string to parse
    /// - Returns:  subsequence of something tokens
    /// Example: Parse string in math tokens
    func parse(expression: String) throws -> [Token]
}
