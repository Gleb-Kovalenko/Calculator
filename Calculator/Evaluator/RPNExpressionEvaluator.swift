//
//  RPNExpressionEvaluator.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

import Foundation

// MARK: - RPNExpressionEvaluator

final class RPNExpressionEvaluator {
    
}

// MARK: - ExpressionEvaluator

extension RPNExpressionEvaluator: ExpressionEvaluator {
    
    func evaluate(expression: [MathExpressionToken]) throws -> Double {
        var expression = expression
        var stack = Stack<MathExpressionToken>()
        while !expression.isEmpty {
            let currentToken = expression.removeFirst()
            switch currentToken {
            case .number:
                stack.push(currentToken)
            case .unaryOperation(.prefixUnaryOperation(let prefixOperation)):
                if case .number(let firstNumber) = stack.pop() {
                    let result = prefixOperation.perform(to: firstNumber)
                    stack.push(.number(result))
                } else {
                    throw EvaluatorError.invalidSyntaxis(message: "Not a number after '\(prefixOperation.rawValue)'")
                }
            case .binaryOperation(let operation):
                if case .number(let secondNumber) = stack.pop(), case .number(let firstNumber) = stack.pop() {
                    let result = operation.perform(to: firstNumber, and: secondNumber)
                    stack.push(.number(result))
                } else {
                    throw EvaluatorError.invalidSyntaxis(message: "'\(operation.rawValue)' not between two numbers")
                }
            case .mathFunction(let function):
                if case .number(let number) = stack.pop() {
                    let result = function.perform(to: number)
                    stack.push(.number(result))
                }
            case .unaryOperation(.postfixUnaryOperation(let operation)):
                    if case .number(let firstNumber) = stack.pop() {
                        let result = try operation.perform(to: firstNumber)
                        stack.push(.number(result))
                    } else {
                        throw EvaluatorError.invalidSyntaxis(message: "Not a number before '\(operation.rawValue)'")
                    }
            default:
                throw EvaluatorError.invalidSyntaxis(message: "Unknown function or unknown operation - \(currentToken)")
            }
        }
        if case .number(let result) = stack.pop() {
            return round(result * 100000) / 100000
        } else {
            throw EvaluatorError.invalidSyntaxis(message: "Result isn't a number")
        }
    }
}
