//
//  CalculatorTest.swift
//  CalculatorTests
//
//  Created by Gleb Kovalenko on 20.07.2022.
//

import XCTest
@testable import Calculator

// MARK: - XCTestCase

final class CalculatorTest: XCTestCase {
    
    private let calculator = CalculatorImplemantation(
        parser: MathExpressionParser(),
        converter: RPNExpressionConverter(),
        evaluator: RPNExpressionEvaluator()
    )
    
    func testCalculator() throws {
        let testDictionary: [String: Double] = [
            "sin(cos(5)) + (1 + -5 - 2.6)×3.9": -25.46013,
            "5 + -3 ÷ 2": 3.5,
            "sin(cos(sin(cos(5 × 3 ^ 3 - -3))))": 0.62656,
            "-5 + 4.21 × 0.941 ÷ 2.3151": -3.28880,
            "sin(-5) + 5 × 2.33 ÷ 5.12 ^ 3.32": 1.01039,
            "9.44 × (sin(5.21) ÷ cos(3.21)) ÷ 5 ^ 2.3": 0.20522,
            "tg(3) - -5.21 × 8.4 ÷ 9.12": 4.65614,
            "5.1 ^ 5.3 × 1.23 - 9.5 ÷ 7.6 × cos(-1.2)": 6918.28760,
            "5.12 + 3.4  - 1.2   ÷ COS(4.1) × sin(CoS(-9.1))": 6.82469,
            "cos(sin(tg(9.152))) × 1.23 ÷ 4.3": 0.27521,
            "(5 × 4 ÷ 2)!": 3628800.0,
            "(3! × 2 ÷ 4)!!": 720.0,
            "3.3!": 8.85534,
            "4.2!": 32.5781,
            "-5.4!": -240.83378,
            "-2.9!": -5.29933
        ]
        for (expression, expectedResult) in testDictionary {
            let calculatorResult = try calculator.calculate(expression: expression)
            XCTAssertEqual(calculatorResult, expectedResult)
        }
    }
}
