//
//  NSDateFormatter.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension MKSwiftExtension where Base: DateFormatter {
    
    // DIY：使用需要更新 `dateFormat` 字段
    public static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_CN")
        return formatter
    }
    
    // yyyy-MM-dd
    public static var yyyy_mm_dd: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.init(identifier: "zh_CN")
        return formatter
    }
    
    // yyyy-M-d
    public static var yyyy_m_d: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.init(identifier: "zh_CN")
        return formatter
    }
}
