//
//  ExpressionParser.swift
//  Calculator
//
//  Created by Глеб Коваленко on 17.07.2022.
//

// MARK - ExpressionParser

protocol ExpressionParser {
    associatedtype Token
    func parse(expression: String) throws -> [Token]
}
