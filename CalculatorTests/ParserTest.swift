//
//  ParserTest.swift
//  CalculatorTests
//
//  Created by GlebKovalenko on 20.07.2022.
//
import XCTest
@testable import Calculator

class ParserTest: XCTestCase {
    
    private let mathParser = MathExpressionParser()

    func testSomething() throws {
        let testDictionary: [String: [MathExpressionToken]] = [
            "sin(cos(5)) + (1 + -5 - 2.6)×3.9": [
                .mathFunction(.sinus),
                .bracket(.open),
                .mathFunction(.cosinus),
                .bracket(.open),
                .number(5.0),
                .bracket(.close),
                .bracket(.close),
                .binaryOperation(.addition),
                .bracket(.open),
                .number(1.0),
                .binaryOperation(.addition),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(5.0),
                .binaryOperation(.substraction),
                .number(2.6),
                .bracket(.close),
                .binaryOperation(.multiply),
                .number(3.9)
            ],
            "5 + -3 ÷ 2" : [
                .number(5.0),
                .binaryOperation(.addition),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(3.0),
                .binaryOperation(.division),
                .number(2.0)
            ],
            "sin(cos(sin(cos(5 × 3 ^ 3 - -3))))" : [
                .mathFunction(.sinus),
                .bracket(.open),
                .mathFunction(.cosinus),
                .bracket(.open),
                .mathFunction(.sinus),
                .bracket(.open),
                .mathFunction(.cosinus),
                .bracket(.open),
                .number(5.0),
                .binaryOperation(.multiply),
                .number(3.0),
                .binaryOperation(.power),
                .number(3.0),
                .binaryOperation(.substraction),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(3.0),
                .bracket(.close),
                .bracket(.close),
                .bracket(.close),
                .bracket(.close)
            ],
            "-5 + 4.21 × 0.941 ÷ 2.3151": [
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(5.0),
                .binaryOperation(.addition),
                .number(4.21),
                .binaryOperation(.multiply),
                .number(0.941),
                .binaryOperation(.division),
                .number(2.3151)
            ],
            "sin(-5) + 5 × 2.33 ÷ 5.12 ^ 3.32": [
                .mathFunction(.sinus),
                .bracket(.open),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(5.0),
                .bracket(.close),
                .binaryOperation(.addition),
                .number(5.0),
                .binaryOperation(.multiply),
                .number(2.33),
                .binaryOperation(.division),
                .number(5.12),
                .binaryOperation(.power),
                .number(3.32)
            ],
            "9.44 × (sin(5.21) ÷ cos(3.21)) ÷ 5 ^ 2.3": [
                .number(9.44),
                .binaryOperation(.multiply),
                .bracket(.open),
                .mathFunction(.sinus),
                .bracket(.open),
                .number(5.21),
                .bracket(.close),
                .binaryOperation(.division),
                .mathFunction(.cosinus),
                .bracket(.open),
                .number(3.21),
                .bracket(.close),
                .bracket(.close),
                .binaryOperation(.division),
                .number(5.0),
                .binaryOperation(.power),
                .number(2.3)
            ],
            "tg(3) - -5.21 × 8.4 ÷ 9.12": [
                .mathFunction(.tg),
                .bracket(.open),
                .number(3.0),
                .bracket(.close),
                .binaryOperation(.substraction),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(5.21),
                .binaryOperation(.multiply),
                .number(8.4),
                .binaryOperation(.division),
                .number(9.12)
            ],
            "5.1 ^ 5.3 × 1.23 - 9.5 ÷ 7.6 × cos(-1.2)": [
                .number(5.1),
                .binaryOperation(.power),
                .number(5.3),
                .binaryOperation(.multiply),
                .number(1.23),
                .binaryOperation(.substraction),
                .number(9.5),
                .binaryOperation(.division),
                .number(7.6),
                .binaryOperation(.multiply),
                .mathFunction(.cosinus),
                .bracket(.open),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(1.2),
                .bracket(.close)
            ],
            "5.12 + 3.4  - 1.2   ÷ COS(4.1) × sin(CoS(-9.1))": [
                .number(5.12),
                .binaryOperation(.addition),
                .number(3.4),
                .binaryOperation(.substraction),
                .number(1.2),
                .binaryOperation(.division),
                .mathFunction(.cosinus),
                .bracket(.open),
                .number(4.1),
                .bracket(.close),
                .binaryOperation(.multiply),
                .mathFunction(.sinus),
                .bracket(.open),
                .mathFunction(.cosinus),
                .bracket(.open),
                .unaryOperation(.prefixUnaryOperation(.negative)),
                .number(9.1),
                .bracket(.close),
                .bracket(.close)
            ],
            "cos(sin(tg(9.152))) × 1.23 ÷ 4.3": [
                .mathFunction(.cosinus),
                .bracket(.open),
                .mathFunction(.sinus),
                .bracket(.open),
                .mathFunction(.tg),
                .bracket(.open),
                .number(9.152),
                .bracket(.close),
                .bracket(.close),
                .bracket(.close),
                .binaryOperation(.multiply),
                .number(1.23),
                .binaryOperation(.division),
                .number(4.3)
            ],
            "(5 × 4 ÷ 2)!": [
                .bracket(.open),
                .number(5.0),
                .binaryOperation(.multiply),
                .number(4.0),
                .binaryOperation(.division),
                .number(2.0),
                .bracket(.close),
                .unaryOperation(.postfixUnaryOperation(.factorial))
            ],
            "(2! × 2 ÷ 2)!!": [
                .bracket(.open),
                .number(2.0),
                .unaryOperation(.postfixUnaryOperation(.factorial)),
                .binaryOperation(.multiply),
                .number(2.0),
                .binaryOperation(.division),
                .number(2.0),
                .bracket(.close),
                .unaryOperation(.postfixUnaryOperation(.factorial)),
                .unaryOperation(.postfixUnaryOperation(.factorial))
            ]
        ]
        for (expression, expectedResult) in testDictionary {
            let parserResult = try mathParser.parse(expression: expression)
            XCTAssertEqual(parserResult.count, expectedResult.count)
            for (parserToken, expectedToken) in zip(parserResult, expectedResult) {
                XCTAssertEqual(parserToken, expectedToken)
            }
        }
    }
}
