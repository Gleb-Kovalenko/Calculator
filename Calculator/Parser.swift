import Foundation

enum BinaryOp: Character, Equatable {
    case addition = "+"
    case substraction = "-"
    case multiply = "*"
    case division = "/"
    case power = "^"
}


enum UnaryOp: Character, Equatable {
    case negative = "_"
}

enum Function: String, Equatable {
    case sin
    case cos
    case tg
}

enum Bracket: Character, Equatable {
    case open = "("
    case close = ")"
}

enum Token: Equatable {
    case number(Double)
    case binaryOp(BinaryOp)
    case unaryOp(UnaryOp)
    case function(Function)
    case bracket(Bracket)
}

enum ParseError: Error {
    case oneMoreDot
    case unknownFunction
    case unknownOperation
}

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


extension Character {
    var isDot: Bool {
        self == Character(".")
    }
}



func parser(enteredString: String) throws -> [Token] {
    print("Входная строка: ", enteredString)
    var noSpacesString = enteredString.replacingOccurrences(of: " ", with: "").lowercased()
    var tokenArray: [Token] = []
    var array: [String] = []
    var tokenString = ""
    
    while !noSpacesString.isEmpty || !tokenString.isEmpty{
        let symbol = !noSpacesString.isEmpty ? noSpacesString.removeFirst() : " "
        if !symbol.isLetter && !symbol.isDot && !symbol.isNumber{
            if let number = Double(tokenString) {
                array.append(tokenString)
                tokenArray.append(Token.number(number))
            } else if tokenString.filter({ $0.isDot }).count > 1{
                throw ParseError.oneMoreDot
            } else if let function = Function(rawValue: tokenString) {
                tokenArray.append(Token.function(function))
                array.append(String(tokenString))
            } else if !tokenString.isEmpty{
                throw ParseError.unknownFunction
            }
            if let binaryOp = BinaryOp(rawValue: symbol) {
                tokenArray.append(Token.binaryOp(binaryOp))
                array.append(String(symbol))
            } else if let unaryOp = UnaryOp(rawValue: symbol) {
                tokenArray.append(Token.unaryOp(unaryOp))
                array.append(String(symbol))
            } else if let bracket = Bracket(rawValue: symbol) {
                tokenArray.append(Token.bracket(bracket))
                array.append(String(symbol))
            } else if symbol != Character(" ") {
                throw ParseError.unknownOperation
            }
            tokenString = ""
        } else {
            tokenString += String(symbol)
        }
    }
    print("Ответ в виде массива строчек:\n",array)
    return tokenArray
}
