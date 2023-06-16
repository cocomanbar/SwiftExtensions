//
//  UIFont.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UIFont {
    
    public func customFont(_ name: String, of size: CGFloat) -> UIFont {
        if let font = UIFont(name: name, size: size) {
            return font
        }
        return Base.systemFont(ofSize: size)
    }
}
