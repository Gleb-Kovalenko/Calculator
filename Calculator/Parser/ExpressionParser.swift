//
//  ExpressionParser.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

// MARK: - ExpressionParser

protocol ExpressionParser {
    
    associatedtype Token
    
    /// Parse string to array of tokens
    /// - Parameter expression: string to parse
    /// - Throws: parser errors, such as one more dot, unknown operation or function
    /// - Returns: sequence of tokens
    /// Example: Parse string to math tokens
    func parse(expression: String) throws -> [Token]
}
