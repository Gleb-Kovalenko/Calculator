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
    
    /// Checked if it is a unary operation character, and if so, returns unary operation token, otherwise nill
    ///
    /// A character is a unary operation when it appears either first in an expression
    /// or not before another number or close bracket
    func isUnaryOperation(previousToken: MathExpressionToken?) -> UnaryOperation? {
        if let unaryOperation = UnaryOperation(rawValue: self) {
            switch previousToken {
            case .number:
                return nil
            case .bracket(let bracket) where bracket == .close:
                return nil
            default:
                return unaryOperation
            }
        }
        return nil
    }
}
