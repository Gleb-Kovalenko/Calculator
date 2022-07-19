//
//  MathExpressionEvaluator.swift
//  Calculator
//
//  Created by Глеб Коваленко on 18.07.2022.
//

import Foundation

// MARK - MathExpressionEvaluator

final class MathExpressionEvaluator: ExpressionEvaluator {
    
    func evaluate(expression: [MathExpressionToken]) throws -> Double {
        
        var expression = expression
        var stack = Stack<MathExpressionToken>()
        
        while !expression.isEmpty {
            let currentToken = expression.removeFirst()
            switch currentToken {
            case .number(let number):
                switch expression.first {
                case .unaryOperation(.negative):
                    stack.push(.number(-number))
                default:
                    stack.push(currentToken)
                }
            case .binaryOperation(let operation):
                if case .number(let secondNumber) = stack.pop() {
                    if case .number(let firstNumber) = stack.pop() {
                        switch operation {
                        case .addition:
                            stack.push(.number(firstNumber + secondNumber))
                        case .substraction:
                            stack.push(.number(firstNumber - secondNumber))
                        case .division:
                            stack.push(.number(firstNumber / secondNumber))
                        case .multiply:
                            stack.push(.number(firstNumber * secondNumber))
                        case .power:
                            stack.push(.number(pow(firstNumber, secondNumber)))
                        }
                    }
                }
            case .mathFunction(let function):
                if case .number(let number) = stack.pop() {
                    switch function {
                    case .sin:
                        stack.push(.number(sin(number)))
                    case .cos:
                        stack.push(.number(cos(number)))
                    case .tg:
                        stack.push(.number(tan(number)))
                    }
                }
            case .unaryOperation:
                continue
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
