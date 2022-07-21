//
//  CalculatorImplemantation.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 20.07.2022.
//

import Foundation

// MARK - CalculatorImplemantation

final class CalculatorImplemantation<ParserType, ConverterType, EvaluatorType> where
    ParserType: ExpressionParser,
    ConverterType: ExpressionConverter,
    EvaluatorType: ExpressionEvaluator,
    ParserType.Token == ConverterType.Token,
    ConverterType.Token == EvaluatorType.Token {
    
    private let expressionParser: ParserType
    private let expressionConverter: ConverterType
    private let expressionEvaluator: EvaluatorType
    
    init(parser: ParserType, converter: ConverterType, evaluator: EvaluatorType) {
        expressionParser = parser
        expressionConverter = converter
        expressionEvaluator = evaluator
    }
}

// MARK - Calculator

extension CalculatorImplemantation: Calculator {
    
    ///Calculate expression
    func calculate(expression: String) throws -> Double {
        let parsedString = try expressionParser.parse(expression: expression)
        let convertedString = try expressionConverter.convert(expression: parsedString)
        let result = try expressionEvaluator.evaluate(expression: convertedString)
        return result
    }
}
