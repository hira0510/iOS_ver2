//
//  BasicTypeExtension.swift
//  iOS_ver2
//
//  Created by Hira on 2023/2/15.
//

import Foundation

extension CGFloat {
    
    func toInt() -> Int {
        return Int(self)
    }
}

extension Double {
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toString() -> String {
        return String(self)
    }
}

extension Int {
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toFloat() -> Float {
        return Float(self)
    }
    
    func toCGFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func toString() -> String {
        return String(self)
    }
}

extension Int64 {
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toFloat() -> Float {
        return Float(self)
    }
    
    func toInt() -> Int {
        return Int(self)
    }
    
    func toString() -> String {
        return String(self)
    }
}

extension String {
    
    func toInt(_ defaultValue: Int = 0) -> Int {
        if let int = Int(self) {
            return int
        }
        return defaultValue
    }
}

extension Float {
    func rounded(digits: Int) -> Float {
        let multiplier = pow(10.0, Float(digits))
        return (self * multiplier).rounded() / multiplier
    }
}
