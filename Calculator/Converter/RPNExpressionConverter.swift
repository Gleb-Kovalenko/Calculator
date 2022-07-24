//
//  RPNExpressionConverter.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 18.07.2022.
//

import Foundation

// MARK: - RPNExpressionConverter

final class RPNExpressionConverter {
    
}

// MARK: - ExpressionConverter

extension RPNExpressionConverter: ExpressionConverter {
    
    func convert(expression: [MathExpressionToken]) throws -> [MathExpressionToken] {
        
        var expression = expression
        var stack = Stack<MathExpressionToken>()
        var convertedTokenArray: [MathExpressionToken] = []
        
        while !expression.isEmpty {
            let currentToken = expression.removeFirst()
            switch currentToken {
            case .number :
                convertedTokenArray.append(currentToken)
            case .mathFunction, .bracket(.open):
                stack.push(currentToken)
            case  .unaryOperation(let operation):
                switch operation {
                case .prefixUnaryOperation:
                    stack.push(currentToken)
                case .postfixUnaryOperation:
                    convertedTokenArray.append(currentToken)
                }
            case .bracket(.close):
                while stack.peek() != .bracket(.open) {
                    if let token = stack.pop() {
                        if stack.isEmpty && token != .bracket(.open) {
                            throw ConverterError.inconsistentBrackets
                        }
                        convertedTokenArray.append(token)
                    }
                }
                stack.pop()
            case .binaryOperation(let binaryOperation):
                var isNeedToPopStack = true
                while isNeedToPopStack {
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
                        isNeedToPopStack = false
                    }
                }
            }
        }
        while let token = stack.pop() {
            switch token {
            case .binaryOperation, .mathFunction, .unaryOperation:
                convertedTokenArray.append(token)
            default:
                throw ConverterError.inconsistentBrackets
            }
        }
        return convertedTokenArray
    }
}
