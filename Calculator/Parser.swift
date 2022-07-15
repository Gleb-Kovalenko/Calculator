import Foundation

// MARK - BinaryOperation

enum BinaryOperation: Character, Equatable {
    case addition = "+"
    case substraction = "-"
    case multiply = "*"
    case division = "/"
    case power = "^"
}

// MARK - UnaryOperation

enum UnaryOperation: Character, Equatable {
    case negative = "-"
}

// MARK - MathFunction

enum MathFunction: String, Equatable {
    case sin
    case cos
    case tg
}

// MARK - Bracket

enum Bracket: Character, Equatable {
    case open = "("
    case close = ")"
}

// MARK - Token

enum Token: Equatable {
    case number(Double)
    case binaryOperation(BinaryOperation)
    case unaryOperation(UnaryOperation)
    case mathFunction(MathFunction)
    case bracket(Bracket)
}

// MARK - ParseError

enum ParseError: Error {
    case oneMoreDot
    case unknownFunction
    case unknownOperation
}

// MARK - LocalizedError

extension ParseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .oneMoreDot:
            return "Error: Some number has more than one dot"
        case .unknownFunction:
            return "Error: No match with some function"
        case .unknownOperation:
            return "Error: No match with some operation"
        }
    }
}

// MARK - Character

extension Character {
    var isDot: Bool {
        self == Character(".")
    }
}

// MARK - ExpressionParser

protocol ExpressionParser {
    associatedtype Item
    func parse(expression: String) throws -> [Item]
}

// MARK - MathExpressionParser

class MathExpressionParser: ExpressionParser {
    func parse(expression: String) throws -> [Token] {
        print("Входная строка: ", expression)
        var noSpacesString = expression.replacingOccurrences(of: " ", with: "").lowercased()
        var tokenArray: [Token] = []
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
