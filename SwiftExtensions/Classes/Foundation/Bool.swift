//
//  Bool.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension MKSwiftExtension where Base == Bool {
    
    public var toInt: Int {
        base ? 1 : 0
    }
    
    public var toString: String {
        base ? "1" : "0"
    }
}
