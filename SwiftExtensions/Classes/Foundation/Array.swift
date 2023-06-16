//
//  Array.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

public extension Array {
    
    /// safe index:
    subscript(safe index: Int) -> Element? {
        if index >= self.count {
            assertionFailure("Index out of bounds!Index: \(index), Count: \(self.count)")
            return nil
        } else {
            return self[index]
        }
    }
}

