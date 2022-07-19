//
//  MathExpressionConverter.swift
//  Calculator
//
//  Created by Глеб Коваленко on 18.07.2022.
//

import Foundation

// MARK - MathExpressionConverter

final class MathExpressionConverter: ExpressionConverter {
    
    func convert(expression: [MathExpressionToken]) throws -> [MathExpressionToken] {
        
        var expression = expression
        var stack = Stack<MathExpressionToken>()
        var convertedTokenArray: [MathExpressionToken] = []
        
        while !expression.isEmpty {
            let currentToken = expression.removeFirst()
            switch currentToken {
            case .number : convertedTokenArray.append(currentToken)
            case .mathFunction, .unaryOperation, .bracket(.open): stack.push(currentToken)
            case .bracket(.close):
                while stack.peek() != .bracket(.open) {
                    if let token = stack.pop(){
                        if stack.isEmpty && token != .bracket(.open) {
                            throw ConverterError.wrongBrackets
                        }
                        convertedTokenArray.append(token)
                    }
                }
                stack.pop()
            case .binaryOperation(let binaryOperation):
                var flag = true
                while flag {
                    switch stack.peek() {
                    case .mathFunction, .unaryOperation:
                        if let token = stack.pop() {
                            convertedTokenArray.append(token)
                        }
                    case .binaryOperation(let anotherBinaryOperation) where anotherBinaryOperation.priority >= binaryOperation.priority:
                        if let token = stack.pop() {
                            convertedTokenArray.append(token)
                        }
                    default:
                        stack.push(currentToken)
                        flag = false
                    }
                }
            }
        }
        while !stack.isEmpty {
            if let token = stack.pop() {
                switch token {
                case .binaryOperation, .mathFunction, .unaryOperation:
                    convertedTokenArray.append(token)
                default:
                    throw ConverterError.wrongBrackets
                }
                
            }
        }
        return convertedTokenArray
    }
}
