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
    
    var buttonColor: Color {
        switch self {
        case .equal, .addition, .multiply, .substraction, .division:
            return .orange
        case .clearAll, .percent, .openBracket, .closeBracket:
            return Color(UIColor.darkGray)
        case .sinus, .cosinus, .power, .factorial, .tangens, .squart, .arctan:
            return .lightDarkGray
        case .point, .digit, .clearLast:
            return .gray
        }
    }
    
    var buttonWidth: CGFloat {
        (UIScreen.main.bounds.width - 5 * 10) / 4
    }
    
    var buttonHeight: CGFloat {
        (UIScreen.main.bounds.height / 2.7 - 5 * 10) / 4
    }
    
    func fontSize(defaultFontSize: CGFloat) -> CGFloat {
        switch self {
        case .sinus, .cosinus, .clearAll:
            return defaultFontSize - 5
        default:
            return defaultFontSize
        }
    }
    
    func action(expression: String, calculator: Calculator?) throws -> String {
        var expression = expression
        switch self {
        case .equal:
            if let calculator = calculator {
                let result = try calculator.calculate(expression: expression)
                if result.truncatingRemainder(dividingBy: 1) == 0 {
                    return String(Int(result))
                }
                return String(result)
            }
            throw CalculatorError.noCalculatorInstance
        case .factorial:
            return expression + "!"
        case .power:
            return expression + "^"
        case .clearAll:
            return ""
        case .clearLast:
            expression.removeLast()
            return expression
        default:
            return expression + self.title
        }
    }
}
