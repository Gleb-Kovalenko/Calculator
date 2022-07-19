//
//  MathExpressionParser.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 17.07.2022.
//

// MARK - MathExpressionParser

final class MathExpressionParser: ExpressionParser {
    
    func parse(expression: String) throws -> [MathExpressionToken] {
        
        var noSpacesString = expression.replacingOccurrences(of: " ", with: "").lowercased()
        var tokenArray: [MathExpressionToken] = []
        var tokenString = ""
        
        while !noSpacesString.isEmpty || !tokenString.isEmpty {
            let symbol = !noSpacesString.isEmpty ? noSpacesString.removeFirst() : " "
            if !symbol.isLetter && !symbol.isDot && !symbol.isNumber {
                if let number = Double(tokenString) {
                    tokenArray.append(.number(number))
                } else if tokenString.filter(\.isDot).count > 1 {
                    throw ParseError.oneMoreDot
                } else if let function = MathFunction(rawValue: tokenString) {
                    tokenArray.append(.mathFunction(function))
                } else if !tokenString.isEmpty {
                    throw ParseError.unknownFunction
                }
                if UnaryOperation(rawValue: symbol) != nil && tokenArray.last == .bracket(.open) {
                    if let unaryOperation = UnaryOperation(rawValue: symbol) {
                        tokenArray.append(.unaryOperation(unaryOperation))
                    }
                } else if let binaryOperation = BinaryOperation(rawValue: symbol) {
                    tokenArray.append(.binaryOperation(binaryOperation))
                } else if let bracket = Bracket(rawValue: symbol) {
                    tokenArray.append(.bracket(bracket))
                } else if symbol != Character(" ") {
                    throw ParseError.unknownOperation
                }
                tokenString = ""
            } else {
                tokenString += String(symbol)
            }
        }
        return tokenArray
    }
}
