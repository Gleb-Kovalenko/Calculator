//
//  MathFunctionToken.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

import Foundation

// MARK: - MathFunction

enum MathFunction: String, Equatable {
    
    case sinus = "sin"
    case cosinus = "cos"
    case tg
    
    func perform(to number: Double) -> Double {
        switch self {
        case .sinus:
            return sin(number)
        case .cosinus:
            return cos(number)
        case .tg:
            return tan(number)
        }
    }
}
