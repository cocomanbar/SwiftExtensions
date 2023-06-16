//
//  UIColor.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UIColor {
    
    public var getRGBA: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        base.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return (red, green, blue, alpha)
    }
    
    public var randomColor: UIColor {
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor.mk.RGB(red, green, blue)
    }
}

extension MKSwiftExtension where Base: UIColor {
    
    public static func RGBSame(_ value: CGFloat) -> Base {
        Base.mk.RGBSame(value, alpha: 1)
    }
    
    public static func RGBSame(_ value: CGFloat, alpha: CGFloat) -> Base {
        Base.mk.RGB(value, value, value, alpha: 1.0)
    }
    
    public static func RGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> Base {
        Base.mk.RGB(red, green, blue, alpha: 1.0)
    }
    
    public static func RGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, alpha: CGFloat) -> Base {
        UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha) as! Base
    }
    
    public static func hex(_ value: String?) -> Base? {
        guard let value = value, value.count > 0 else { return nil }
        
        var upperHex = value.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if upperHex.count < 6 {
            return nil
        }
        if upperHex.hasPrefix("#") {
            let index = upperHex.index(upperHex.startIndex, offsetBy: 1)
            upperHex = String(upperHex[index...])
        } else if upperHex.hasPrefix("0X") {
            let index = upperHex.index(upperHex.startIndex, offsetBy: 2)
            upperHex = String(upperHex[index...])
        }
        if upperHex.count != 6 && upperHex.count != 8 {
            return nil
        }
        let scanner = Scanner(string: upperHex)
        var hexNumer: UInt64 = 0
        if scanner.scanHexInt64(&hexNumer) {
            if upperHex.count == 6 { // RGB
                let R = CGFloat((hexNumer & 0xFF0000) >> 16) / 255
                let G = CGFloat((hexNumer & 0x00FF00) >> 8) / 255
                let B = CGFloat(hexNumer & 0x0000FF) / 255
                return Base.init(red: R, green: G, blue: B, alpha: 1)
            } else if upperHex.count == 8 { // RGBA
                let R = CGFloat((hexNumer & 0xFF000000) >> 24) / 255
                let G = CGFloat((hexNumer & 0x00FF0000) >> 16) / 255
                let B = CGFloat((hexNumer & 0x0000FF00) >> 8) / 255
                let A = CGFloat(hexNumer & 0x000000FF) / 255
                return Base.init(red: R, green: G, blue: B, alpha: A)
            }
        }
        return nil
    }
}
