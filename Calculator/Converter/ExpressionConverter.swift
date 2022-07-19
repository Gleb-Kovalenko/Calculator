//
//  ExpressionConverter.swift
//  Calculator
//
//  Created by Глеб Коваленко on 18.07.2022.
//

// MARK - ExpressionConverter

protocol ExpressionConverter {
    
    associatedtype Token: Equatable
    
    func convert(expression: [Token]) throws -> [Token]
}
