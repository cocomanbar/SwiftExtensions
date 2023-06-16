//
//  Int.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension Int: MKSwiftExtensionCompatibleValue {}

extension MKSwiftExtension where Base == Int {
    
    /// 偶数
    public var isEven: Bool {
        base % 2 == 0
    }
    
    /// 奇数
    public var isOdd: Bool {
        !isEven
    }
    
    /// 通用显示格式
    /// - Returns: "00:00" or "00:00:00"
    public func stringFromSeconds() -> String {
        if base <= 0 {
            return "00:00"
        }
        let hour: Int = base / 60 / 60
        let minute: Int = base / 60 % 60
        let second: Int = base % 60
        
        if hour > 0 {
            return String.init(format: "%02d:%02d:%02d", hour, minute, second)
        }
        return String.init(format: "%02d:%02d", minute, second)
    }
}
