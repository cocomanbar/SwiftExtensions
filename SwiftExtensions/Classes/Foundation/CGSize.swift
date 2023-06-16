//
//  CGSize.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension CGSize: MKSwiftExtensionCompatibleValue {}

extension MKSwiftExtension where Base == CGSize {
    
    public var isBothZero: Bool {
        base.width == 0 && base.height == 0
    }
    
    public var isSideZero: Bool {
        base.width == 0 || base.height == 0
    }
}

extension MKSwiftExtension where Base == CGSize {
    
    public func ratioHeight(_ width: CGFloat) -> CGFloat {
        if base.width == 0 {
            return 0
        }
        return width * (base.height / base.width)
    }
    
    public func ratioWidth(_ height: CGFloat) -> CGFloat {
        if base.height == 0 {
            return 0
        }
        return height * (base.width / base.height)
    }
}
