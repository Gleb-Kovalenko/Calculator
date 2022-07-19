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
    /// - Parameter expression: string to parse
    /// - Throws: Parser errors, such as one more dot, unknown operation or function
    /// - Returns: sequence of something tokens
    /// Example: Parse string in math tokens
    func parse(expression: String) throws -> [Token]
}
