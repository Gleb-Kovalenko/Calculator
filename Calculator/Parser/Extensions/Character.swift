//
//  Character.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

// MARK - Character

extension Character {
    var isDot: Bool {
        self == Character(".")
    }
    
    /// Checked if it is a prefix unary operation character, and if so, returns prefix unary operation token, otherwise nill
    ///
    /// A character is a prefix unary operation when it appears either first in an expression
    /// or not before another number or close bracket
    func isPrefixUnaryOperation(previousToken: MathExpressionToken?) -> PrefixUnaryOperation? {
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
    
    /// Checked if it is a postfix unary operation character, and if so, returns postfix unary operation token, otherwise nill
    ///
    /// A character is a postfix unary operation when it before another number or close bracket
    func isPostfixUnaryOperation(previousToken: MathExpressionToken?) -> PostfixUnaryOperation? {
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
