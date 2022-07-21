//
//  RPNExpressionEvaluator.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

import Foundation

// MARK - RPNExpressionEvaluator

final class RPNExpressionEvaluator {
    
}

// MARK - ExpressionEvaluator

extension RPNExpressionEvaluator: ExpressionEvaluator {
    
    /// Calculate recieved RPN expression
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
                    let result = prefixOperation.doOperation(number: firstNumber)
                    stack.push(.number(result))
                } else {
                    throw EvaluatorError.invalidSyntaxis
                }
            case .binaryOperation(let operation):
                if case .number(let secondNumber) = stack.pop() {
                    if case .number(let firstNumber) = stack.pop() {
                        let result = operation.doOperation(firstNumber: firstNumber, secondNumber: secondNumber)
                        stack.push(.number(result))
                    } else {
                        throw EvaluatorError.invalidSyntaxis
                    }
                } else {
                    throw EvaluatorError.invalidSyntaxis
                }
            case .mathFunction(let function):
                if case .number(let number) = stack.pop() {
                    let result = function.doFunction(number: number)
                    stack.push(.number(result))
                }
            case .unaryOperation(.postfixUnaryOperation(let operation)):
                    if case .number(let firstNumber) = stack.pop() {
                        do {
                            let result = try operation.doOperation(number: firstNumber)
                            stack.push(.number(result))
                        } catch {
                            throw error
                        }
                    } else {
                        throw EvaluatorError.invalidSyntaxis
                    }
            default:
                throw EvaluatorError.invalidSyntaxis
            }
        }
        if case .number(let result) = stack.pop() {
            return round(result * 100000)/100000
        } else {
            throw EvaluatorError.invalidSyntaxis
        }
    }
}
