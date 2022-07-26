//
//  Character.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

// MARK: - Character

extension Character {
    
    var isDot: Bool {
        self == Character(".")
    }
    
    /// Check if it is a prefix unary operation character and returns prefix unary operation token if it's exists
    ///
    /// A character is a prefix unary operation when it appears either first in an expression
    /// or not before another number or close bracket
    func getPrefixUnaryOperation(previousToken: MathExpressionToken?) -> PrefixUnaryOperation? {
        if let prefixOperation = PrefixUnaryOperation(rawValue: self) {
            switch previousToken {
            case .number:
                return nil
            case .bracket(let bracket) where bracket == .close:
                return nil
            default:
                return prefixOperation
            }
        }
        return nil
    }
    
    /// Check if it is a postfix unary operation character and returns postfix unary operation token if it's exists
    ///
    /// A character is a postfix unary operation when it before another number or close bracket
    func getPostfixUnaryOperation(previousToken: MathExpressionToken?) -> PostfixUnaryOperation? {
        if let postfixOperation = PostfixUnaryOperation(rawValue: self) {
            switch previousToken {
            case .number, .unaryOperation(.postfixUnaryOperation):
                return postfixOperation
            case .bracket(let bracket) where bracket == .close:
                return postfixOperation
            default:
                return nil
            }
        }
        return nil
    }
}
