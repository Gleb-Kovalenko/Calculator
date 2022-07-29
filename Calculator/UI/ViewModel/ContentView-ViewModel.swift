//
//  ContentView-ViewModel.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 27.07.2022.
//

import Foundation
import SwiftUI

// MARK: - ContentView

extension ContentView {
    
    // MARK: - CalculatorState
    
    enum CalculatorState {
        case expression(String)
        case error(Error)
    }
    
    // MARK: - ButtonShape
    
    enum ButtonShape {
        case rounded
        case circle
    }
    
    // MARK: - ObservableObject
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var calculatorState: CalculatorState = .expression("")
        @Published private(set) var buttonShape: ButtonShape = .rounded
        private var expression = ""
        
        /// RPNCalculator instance
        private var calculator = CalculatorImplementation(
            parser: MathExpressionParser(),
            converter: RPNExpressionConverter(),
            evaluator: RPNExpressionEvaluator()
        )
        
        func buttonTapped(button: CalculatorButton) {
            do {
                switch button {
                case .equal:
                    let result = try calculator.calculate(expression: expression)
                    if result.truncatingRemainder(dividingBy: 1) == 0 {
                        expression = String(Int(result))
                    } else {
                        expression = String(result)
                    }
                case .factorial:
                    expression += "!"
                case .power:
                    expression += "^"
                case .clearAll:
                    expression = ""
                case .clearLast:
                    expression.removeLast()
                default:
                    expression += button.title
                }
                calculatorState = .expression(expression)
            } catch let error {
                expression = ""
                calculatorState = .error(error)
            }
        }
        
        func displayTextView() -> Text {
            switch calculatorState {
            case .expression(let expression):
                return Text(expression)
            case .error(let error):
                return Text(error.localizedDescription)
            }
        }
    }
}
