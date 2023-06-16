//
//  RangeFloat.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

@propertyWrapper
public struct RangeFloat {
    
    private var minimum: Float
    private var maximum: Float
    private var number: Float
    
    public var wrappedValue: Float {
        get { return number }
        set { number = min((max(newValue, minimum)), maximum) }
    }
    
    public init() {
        number = 0
        minimum = 0
        maximum = 1
    }
    
    public init(wrappedValue: Float) {
        number = wrappedValue
        minimum = 0
        maximum = 1
    }
    
    public init(wrappedValue: Float, min: Float, max: Float) {
        number = wrappedValue
        minimum = min
        maximum = max
    }
}
