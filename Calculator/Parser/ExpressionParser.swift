//
//  ExpressionParser.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

// MARK - ExpressionParser

protocol ExpressionParser {
    
    associatedtype Token
    
    func parse(expression: String) throws -> [Token]
}
