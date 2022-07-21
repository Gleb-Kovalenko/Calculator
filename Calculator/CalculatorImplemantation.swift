//
//  CalculatorImplemantation.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 20.07.2022.
//

import Foundation

// MARK: - CalculatorImplemantation

final class CalculatorImplemantation<ParserType, ConverterType, EvaluatorType>
    where
        ParserType: ExpressionParser,
        ConverterType: ExpressionConverter,
        EvaluatorType: ExpressionEvaluator,
        ParserType.Token == ConverterType.Token,
        ConverterType.Token == EvaluatorType.Token {

    // MARK: - Properties

    /// Parser instance
    private let expressionParser: ParserType

    /// Converter instance
    private let expressionConverter: ConverterType

    /// Evaluator instance
    private let expressionEvaluator: EvaluatorType

    // MARK: - Initializers

    /// Default initializer
    /// - Parameters:
    ///   - parser: Parser instance
    ///   - converter: Converter instance
    ///   - evaluator: Evaluator instance
    init(parser: ParserType, converter: ConverterType, evaluator: EvaluatorType) {
        expressionParser = parser
        expressionConverter = converter
        expressionEvaluator = evaluator
    }
}

// MARK: - Calculator

extension CalculatorImplemantation: Calculator {
    
    /// Calculate expression
    /// - Parameter expression: expression to calculate
    /// - Throws: evaluator errors, such as invalid syntaxis, or when expression can't be evaluated
    /// - Returns: value as Double
    func calculate(expression: String) throws -> Double {
        let parsedString = try expressionParser.parse(expression: expression)
        let convertedString = try expressionConverter.convert(expression: parsedString)
        let result = try expressionEvaluator.evaluate(expression: convertedString)
        return result
    }
}
