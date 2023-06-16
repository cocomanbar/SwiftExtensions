//
//  CAGradientLayer.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension MKSwiftExtension where Base: CAGradientLayer {
    
    /// 创建渐变Layer
    public static func gradient(
        start: CGPoint = CGPoint(x: 0, y: 0.5),
        end: CGPoint = CGPoint(x: 1, y: 0.5),
        locations: [NSNumber]? = [NSNumber(0), NSNumber(1)],
        colors: [Any]?) -> CAGradientLayer {
            let gradientLayer = CAGradientLayer()
            gradientLayer.startPoint = start
            gradientLayer.endPoint = end
            gradientLayer.colors = colors
            gradientLayer.locations = locations
            return gradientLayer
        }
    
    /// 水平居中渐变，默认从左至右
    public static func gradientHorizontal(_ colors: [Any]?, isPositive: Bool = true) -> CAGradientLayer {
        let start: CGPoint = isPositive ? CGPoint(x: 0, y: 0.5) : CGPoint(x: 1, y: 0.5)
        let end: CGPoint = isPositive ? CGPoint(x: 1, y: 0.5): CGPoint(x: 0, y: 0.5)
        return gradient(start: start, end: end, colors: colors)
    }
    
    /// 垂直居中渐变，默认从上至下
    public static func gradientVertical(_ colors: [Any]?, isPositive: Bool = true) -> CAGradientLayer {
        let start: CGPoint = isPositive ? CGPoint(x: 0.5, y: 0) : CGPoint(x: 0.5, y: 1)
        let end: CGPoint = isPositive ? CGPoint(x: 0.5, y: 1): CGPoint(x: 0.5, y: 0)
        return gradient(start: start, end: end, colors: colors)
    }
}
