//
//  MathExpressionToken.swift
//  Calculator
//
//  Created by Глеб Коваленко on 17.07.2022.
//

// MARK - MathExpressionToken

enum MathExpressionToken: Equatable {
    case number(Double)
    case binaryOperation(BinaryOperation)
    case unaryOperation(UnaryOperation)
    case mathFunction(MathFunction)
    case bracket(Bracket)
}
