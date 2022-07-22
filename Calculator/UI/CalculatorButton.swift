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
    case sinus, cosinus, factorial, openBracket, closeBracket, addition, substraction,
        division, multiply, power, equal, point, clearAll, clearLast, percent
    
    var title: String {
        switch self {
        case .digit(let digit):
            return String(digit)
        case .sinus:
            return "sin"
        case .cosinus:
            return "cos"
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
        }
    }
    
    var buttonColor: Color {
        switch self {
        case .equal, .addition, .multiply, .substraction, .division:
            return .orange
        case .clearAll, .percent, .openBracket, .closeBracket:
            return Color(UIColor.darkGray)
        case .sinus, .cosinus, .power, .factorial:
            return .lightDarkGray
        case .point, .digit, .clearLast:
            return .gray
        }
    }
    var buttonWidth: CGFloat {
        return ((UIScreen.main.bounds.width - 5 * 10) / 5)
    }
    var buttonHeight: CGFloat {
        return ((UIScreen.main.bounds.height / 1.5 - 5 * 10) / 5)
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
        case .digit(let digit):
            return expression + String(digit)
        case .sinus:
            return expression + "sin"
        case .cosinus:
            return expression + "cos"
        case .factorial:
            return expression + "!"
        case .openBracket:
            return expression + "("
        case .closeBracket:
            return expression + ")"
        case .addition:
            return expression + "+"
        case .substraction:
            return expression + "-"
        case .division:
            return expression + "÷"
        case .multiply:
            return expression + "×"
        case .power:
            return expression + "^"
        case .equal:
            let result = try calculator!.calculate(expression: expression)
            if result.truncatingRemainder(dividingBy: 1) == 0 {
                return String(Int(result))
            }
            return String(result)
        case .point:
            return expression + "."
        case .clearAll:
            return ""
        case .percent:
            return expression + "%"
        case .clearLast:
            expression.removeLast()
            return expression
        }
    }
}
