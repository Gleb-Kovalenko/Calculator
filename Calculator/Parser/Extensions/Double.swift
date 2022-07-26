//
//  Double.swift
//  Calculator
//
//  Created by Gleb Kovalenko on 21.07.2022.
//

import Foundation

// MARK: - Double

extension Double {
    func factorial() -> Double? {
        if self <= 14 && self >= -14.0 {
            if self == 0.0 || self == 1.0 {
                return 1
            }
            if self > 0 {
                return tgamma(self + 1.0)
            }
            return -tgamma(self + 1.0)
        } else {
            return nil
        }
    }
}
