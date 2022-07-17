//
//  ParseError.swift
//  Calculator
//
//  Created by Глеб Коваленко on 17.07.2022.
//

// MARK - ParseError

enum ParseError: Error {
    case oneMoreDot
    case unknownFunction
    case unknownOperation
}
