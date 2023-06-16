//
//  Date.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension Date: MKSwiftExtensionCompatibleValue {}

extension MKSwiftExtension where Base == Date {
    
    /// 格式化
    public func string(_ format: String) -> String? {
        let dateFormatter = DateFormatter.mk.dateFormatter
        dateFormatter.dateFormat = format
        return dateFormatter.string(for: base)
    }
    
    /// 时间戳
    public var dateTimestamp: String {
        "\(Int(base.timeIntervalSince1970))"
    }
    
    /// 是否是今天，维度`Day`
    public var isToDay: Bool {
        Calendar.current.isDateInToday(base)
    }
    
    public var isTomorrowDay: Bool {
        Calendar.current.isDateInTomorrow(base)
    }
    
    public var isInWeekend: Bool {
        Calendar.current.isDateInWeekend(base)
    }
    
    public var isInWorkDay: Bool {
        !isInWeekend
    }
    
    public var isYesterday: Bool {
        Calendar.current.isDateInYesterday(base)
    }
    
    public var isInCurrentYear: Bool {
        Calendar.current.isDate(base, equalTo: Date(), toGranularity: .year)
    }
    
    public var isInCurrentMonth: Bool {
        Calendar.current.isDate(base, equalTo: Date(), toGranularity: .month)
    }
    
    public var isInCurrentWeek: Bool {
        Calendar.current.isDate(base, equalTo: Date(), toGranularity: .weekOfYear)
    }
    
    /// 是否是将来，维度`Day`
    public var isFutureDay: Bool {
        let unit: Set<Calendar.Component> = [.day, .month, .year]
        let component = Calendar.current.dateComponents(unit, from: base)
        let currentComponent = Calendar.current.dateComponents(unit, from: Date())
        if (component.year ?? 0 > currentComponent.year ?? 0) ||
            (component.year == currentComponent.year && (component.month ?? 0 > currentComponent.month ?? 0)) ||
            (component.year == currentComponent.year && component.month == currentComponent.month && (component.day ?? 0 > currentComponent.day ?? 0)) {
            return true
        }
        return false
    }
    
}


extension MKSwiftExtension where Base == Date {
    
    /// 间隔天数
    public func betweenDays(_ date: Date) -> Int {
        var diff: TimeInterval = base.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/86400)
        return Int(diff)
    }
    
    /// 间隔小时数
    public func betweenHours(_ date: Date) -> Int {
        var diff: TimeInterval = base.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/3600)
        return Int(diff)
    }
    
    /// 间隔分钟数
    public func betweenMinites(_ date: Date) -> Int {
        var diff: TimeInterval = base.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/60)
        return Int(diff)
    }
    
    /// 间隔秒数
    public func betweenSeconds(_ date: Date) -> Int {
        var diff: TimeInterval = base.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return Int(diff)
    }
    
    /// 增加天数
    func addDays(_ days: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.day = days
        guard let newDate = Calendar.current.date(byAdding: dateComponents, to: base) else { return nil }
        return newDate
    }
    
    /// 增加月数
    func addMonths(_ months: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.month = months
        guard let newDate = Calendar.current.date(byAdding: dateComponents, to: base) else { return nil }
        return newDate
    }
    
    /// 增加年数
    func addYears(_ years: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = years
        guard let newDate = Calendar.current.date(byAdding: dateComponents, to: base) else { return nil }
        return newDate
    }
    
    /// 增加小时数
    func addHours(_ hours: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.hour = hours
        guard let newDate = Calendar.current.date(byAdding: dateComponents, to: base) else { return nil }
        return newDate
    }
}
