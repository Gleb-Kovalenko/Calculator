//
//  Double.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 21.07.2022.
//

import Foundation

// MARK: - Double

extension Double {
    
    var isInt: Bool {
        return floor(self) == self
    }
    
    func factorial() -> Double? {
        if self.isInt && self >= 0 && self <= 14 {
            if self == 0.0 || self == 1.0 {
                return 1
            }
            return Double((2...Int(self)).reduce(1, { $0 * $1 }))
        } else {
            return nil
        }
    }
}
