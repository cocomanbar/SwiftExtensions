//
//  RangeInt.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

@propertyWrapper
public struct RangeInt {
    
    private var minimum: Int
    private var maximum: Int
    private var number: Int
    
    public var wrappedValue: Int {
        get { return number }
        set { number = min((max(newValue, minimum)), maximum) }
    }
    
    public init() {
        number = 0
        minimum = 0
        maximum = 1
    }
    
    public init(wrappedValue: Int) {
        number = wrappedValue
        minimum = 0
        maximum = 1
    }
    
    public init(wrappedValue: Int, min: Int, max: Int) {
        number = wrappedValue
        minimum = min
        maximum = max
    }
}
