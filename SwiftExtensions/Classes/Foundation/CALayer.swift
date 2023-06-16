//
//  CALayer.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension MKSwiftExtension where Base: CALayer {
    
    public func corner(_ cornerRadius: CGFloat) {
        base.cornerRadius = cornerRadius
        base.masksToBounds = true
    }
    
    public func backgroundColor(_ color: UIColor?) {
        base.backgroundColor = color?.cgColor
    }
    
}

