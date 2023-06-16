//
//  MKSwiftExtension.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

public struct MKSwiftExtension<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol MKSwiftExtensionCompatible: AnyObject { }

public protocol MKSwiftExtensionCompatibleValue {}

extension MKSwiftExtensionCompatible {
    
    public var mk: MKSwiftExtension<Self> {
        get { return MKSwiftExtension(self) }
    }
    
    public static var mk: MKSwiftExtension<Self>.Type {
        get { return MKSwiftExtension<Self>.self }
    }
}

extension MKSwiftExtensionCompatibleValue {
    
    public var mk: MKSwiftExtension<Self> {
        get { return MKSwiftExtension(self) }
    }
    
    public static var mk: MKSwiftExtension<Self>.Type {
        get { return MKSwiftExtension<Self>.self }
    }
}

extension NSObject: MKSwiftExtensionCompatible {}
