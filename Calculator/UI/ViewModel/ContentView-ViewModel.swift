//
//  ContentView-ViewModel.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 27.07.2022.
//

import Foundation
import MapKit

// MARK: - ContentView

extension ContentView {
    
    // MARK: - ObservableObject
    
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var expression = ""
        @Published private(set) var calculatorDisplay = ""
        private var calculator = CalculatorImplementation(
            parser: MathExpressionParser(),
            converter: RPNExpressionConverter(),
            evaluator: RPNExpressionEvaluator()
        )
        
        func addAction(of item: CalculatorButton) {
            do {
                switch item {
                case .equal:
                    expression = try item.action(expression: expression, calculator: calculator)
                    calculatorDisplay = expression
                default:
                    expression = try item.action(expression: expression, calculator: nil)
                    calculatorDisplay = expression
                }
            } catch let error {
                calculatorDisplay = error.localizedDescription
                expression = ""
            }
        }
    }
}
