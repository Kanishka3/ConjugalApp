//
//  Collection+Extensions.swift
//  ConjugalApp
//
//  Created by Kanishka Chaudhry on 05/11/24.
//

import Foundation

public extension MutableCollection {
    /// Safely getting the array items 
    subscript (safe index: Index) -> Element? {
        get {
            guard index >= startIndex, index < endIndex else {
                return nil
            }
            
            return self[index]
        }
        
        mutating set(newValue) {
            if let newValue = newValue, index >= startIndex, index < endIndex {
                self[index] = newValue
            }
        }
    }
}
