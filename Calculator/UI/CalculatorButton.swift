//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 22.07.2022.
//

import SwiftUI

// MARK: - CalculatorButton

enum CalculatorButton {
    
    case digit(Character)
    case sinus
    case cosinus
    case tangens
    case arctan
    case factorial
    case squart
    case openBracket
    case closeBracket
    case addition
    case substraction
    case division
    case multiply
    case power
    case equal
    case point
    case clearAll
    case clearLast
    case percent
    
    var title: String {
        switch self {
        case .digit(let digit):
            return String(digit)
        case .sinus:
            return "sin"
        case .cosinus:
            return "cos"
        case .tangens:
            return "tg"
        case .factorial:
            return "x!"
        case .openBracket:
            return "("
        case .closeBracket:
            return ")"
        case .addition:
            return "+"
        case .substraction:
            return "-"
        case .division:
            return "÷"
        case .multiply:
            return "×"
        case .power:
            return "xʸ"
        case .equal:
            return "="
        case .point:
            return "."
        case .clearAll:
            return "AC"
        case .percent:
            return "%"
        case .clearLast:
            return "←"
        case .squart:
            return "√"
        case .arctan:
            return "arctg"
        }
    }
}
