//
//  RPNConverterTest.swift
//  CalculatorTests
//
//  Created by GlebKovalenko on 20.07.2022.
//
import XCTest
@testable import Calculator

// MARK: - XCTestCase

final class RPNConverterTest: XCTestCase {
    
    private let mathParser = MathExpressionParser()
    private let mathConverter = RPNExpressionConverter()

    func testConverter() throws {
        let testDictionary: [String: [MathExpressionToken]] = [
            "sin(cos(5)) + (1 + (-5) - 2.6)×3.9": [
                .number(5.0),
                .mathFunction(.cosinus),
                .mathFunction(.sinus),
                .number(1.0),
                .number(5.0),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .binaryOperation(.addition),
                .number(2.6),
                .binaryOperation(.substraction),
                .number(3.9),
                .binaryOperation(.multiply),
                .binaryOperation(.addition)
            ],
            "5 + (-3) ÷ 2": [
                .number(5.0),
                .number(3.0),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(2.0),
                .binaryOperation(.division),
                .binaryOperation(.addition)
            ],
            "sin(cos(sin(cos(5 × 3 ^ 3 - (-3)))))" : [
                .number(5.0),
                .number(3.0),
                .number(3.0),
                .binaryOperation(.power),
                .binaryOperation(.multiply),
                .number(3.0),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .binaryOperation(.substraction),
                .mathFunction(.cosinus),
                .mathFunction(.sinus),
                .mathFunction(.cosinus),
                .mathFunction(.sinus)
            ],
            "(-5) + 4.21 × 0.941 ÷ 2.3151": [
                .number(5.0),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(4.21),
                .number(0.941),
                .binaryOperation(.multiply),
                .number(2.3151),
                .binaryOperation(.division),
                .binaryOperation(.addition)
            ],
            "sin((-5)) + 5 × 2.33 ÷ 5.12 ^ 3.32": [
                .number(5.0),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .mathFunction(.sinus),
                .number(5.0),
                .number(2.33),
                .binaryOperation(.multiply),
                .number(5.12),
                .number(3.32),
                .binaryOperation(.power),
                .binaryOperation(.division),
                .binaryOperation(.addition)
            ],
            "9.44 × (sin(5.21) ÷ cos(3.21)) ÷ 5 ^ 2.3": [
                .number(9.44),
                .number(5.21),
                .mathFunction(.sinus),
                .number(3.21),
                .mathFunction(.cosinus),
                .binaryOperation(.division),
                .binaryOperation(.multiply),
                .number(5.0),
                .number(2.3),
                .binaryOperation(.power),
                .binaryOperation(.division)
            ],
            "tg(3) - (-5.21) × 8.4 ÷ 9.12": [
                .number(3.0),
                .mathFunction(.tg),
                .number(5.21),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(8.4),
                .binaryOperation(.multiply),
                .number(9.12),
                .binaryOperation(.division),
                .binaryOperation(.substraction)
            ],
            "5.1 ^ 5.3 × 1.23 - 9.5 ÷ 7.6 × cos((-1.2))": [
                .number(5.1),
                .number(5.3),
                .binaryOperation(.power),
                .number(1.23),
                .binaryOperation(.multiply),
                .number(9.5),
                .number(7.6),
                .binaryOperation(.division),
                .number(1.2),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .mathFunction(.cosinus),
                .binaryOperation(.multiply),
                .binaryOperation(.substraction)
            ],
            "5.12 + 3.4  - 1.2   ÷ COS(4.1) × sin(CoS((-9.1)))": [
                .number(5.12),
                .number(3.4),
                .binaryOperation(.addition),
                .number(1.2),
                .number(4.1),
                .mathFunction(.cosinus),
                .binaryOperation(.division),
                .number(9.1),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .mathFunction(.cosinus),
                .mathFunction(.sinus),
                .binaryOperation(.multiply),
                .binaryOperation(.substraction)
            ],
            "cos(sin(tg(9.152))) × 1.23 ÷ 4.3": [
                .number(9.152),
                .mathFunction(.tg),
                .mathFunction(.sinus),
                .mathFunction(.cosinus),
                .number(1.23),
                .binaryOperation(.multiply),
                .number(4.3),
                .binaryOperation(.division)
            ],
            "(5 × 4 ÷ 2)!": [
                .number(5.0),
                .number(4.0),
                .binaryOperation(.multiply),
                .number(2.0),
                .binaryOperation(.division),
                .unaryOperation(.postfixUnaryOperation(.factorial))
            ],
            "(2! × 2 ÷ 2)!!": [
                .number(2.0),
                .unaryOperation(.postfixUnaryOperation(.factorial)),
                .number(2.0),
                .binaryOperation(.multiply),
                .number(2.0),
                .binaryOperation(.division),
                .unaryOperation(.postfixUnaryOperation(.factorial)),
                .unaryOperation(.postfixUnaryOperation(.factorial))
            ]
        ]
        
        for (expression, expectedResult) in testDictionary {
            let parserResult = try mathParser.parse(expression: expression)
            let conveterResult = try mathConverter.convert(expression: parserResult)
            XCTAssertEqual(conveterResult.count, expectedResult.count)
            for (converterToken, expectedToken) in zip(conveterResult, expectedResult) {
                XCTAssertEqual(converterToken, expectedToken)
            }
        }
    }
}
