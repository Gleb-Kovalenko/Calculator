//
//  UnaryOperationToken.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

// MARK: - UnaryOperation

enum UnaryOperation: Equatable {
    case prefixUnaryOperation(PrefixUnaryOperation)
    case postfixUnaryOperation(PostfixUnaryOperation)
}
