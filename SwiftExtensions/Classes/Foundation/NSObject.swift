//
//  NSObject.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: NSObject {
    
    /// 类名
    public var className: String {
        type(of: self).className
    }
    
    /// 类名
    public static var className: String {
        String(describing: self)
    }
}


// MARK: - NotificationCenter

extension MKSwiftExtension where Base: NSObject {
    
    /// 添加通知
    public func addNotificationObserver(_ name: String, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(base, selector: selector, name: Notification.Name(rawValue: name), object: object)
    }
    
    /// 添加通知
    public func addNotificationObserver(_ name: NSNotification.Name, selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(base, selector: selector, name: name, object: object)
    }
    
    /// 移除通知
    public func removeNotificationObserver(_ name: String, object: Any? = nil) {
        NotificationCenter.default.removeObserver(base, name: Notification.Name(rawValue: name), object: object)
    }
    
    /// 移除通知
    public func removeNotificationObserver(_ name: Notification.Name, object: Any? = nil) {
        NotificationCenter.default.removeObserver(base, name: name, object: object)
    }
    
    /// 移除通知
    public func removeNotificationsObserver() {
        NotificationCenter.default.removeObserver(base)
    }
    
    /// 是否注册某个key-path监听
    public func oberseredKeyPath(_ keyPath: String) -> Bool {
        guard let info = base.observationInfo as? AnyObject,
              let array = info.value(forKey: "_observances") as? Array<Any> else {
            return false
        }
        for item in array {
            let objc = item as AnyObject
            guard let property = objc.value(forKey: "_property") as? AnyObject,
                  let path = property.value(forKey: "_keyPath") as? String
            else { continue }
            if keyPath == path {
                return true
            }
        }
        return false
    }
}

// MARK: - Keyboard Notification

extension MKSwiftExtension where Base: NSObject {
    
    public func keyboardWillShowNotification(_ notif: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillShowNotification,
                                               object: nil, queue: OperationQueue.main, using: notif)
    }
    
    public func keyboardDidShowNotification(_ notif: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardDidShowNotification,
                                               object: nil, queue: OperationQueue.main, using: notif)
    }
    
    public func keyboardWillHideNotification(_ notif: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillHideNotification,
                                               object: nil, queue: OperationQueue.main, using: notif)
    }
    
    public func keyboardDidHideNotification(_ notif: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardDidHideNotification,
                                               object: nil, queue: OperationQueue.main, using: notif)
    }
    
    public func keyboardWillChangeFrameNotification(_ notif: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardWillChangeFrameNotification,
                                               object: nil, queue: OperationQueue.main, using: notif)
    }
    
    public func keyboardDidChangeFrameNotification(_ notif: @escaping (Notification) -> Void) {
        NotificationCenter.default.addObserver(forName: UIApplication.keyboardDidChangeFrameNotification,
                                               object: nil, queue: OperationQueue.main, using: notif)
    }
}

// MARK: - Runtime

extension MKSwiftExtension where Base: NSObject {
    
    /// 替换实例方法
    public static func hookInstanceMethod(of origSel: Selector, with replSel: Selector) -> Bool {
        let clz: AnyClass = Base.classForCoder()
        guard let oriMethod = class_getInstanceMethod(clz, origSel) as Method?,
              let repMethod = class_getInstanceMethod(clz, replSel) as Method? else {
            return false
        }
        let didAddMethod: Bool = class_addMethod(clz, origSel, method_getImplementation(repMethod), method_getTypeEncoding(repMethod))
        if didAddMethod {
            class_replaceMethod(clz, replSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod))
        } else {
            method_exchangeImplementations(oriMethod, repMethod)
        }
        return true
    }
    
    /// 替换类方法
    public static func hookClassMethod(of origSel: Selector, with replSel: Selector) -> Bool {
        let clz: AnyClass = Base.classForCoder()
        guard let oriMethod = class_getClassMethod(clz, origSel) as Method?,
              let repMethod = class_getClassMethod(clz, replSel) as Method? else {
            return false
        }
        let didAddMethod: Bool = class_addMethod(clz, origSel, method_getImplementation(repMethod), method_getTypeEncoding(repMethod))
        if didAddMethod {
            class_replaceMethod(clz, replSel, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod))
        } else {
            method_exchangeImplementations(oriMethod, repMethod)
        }
        return true
    }
}

extension MKSwiftExtension where Base: NSObject {
    
    /// 成员变量列表
    public static func ivarsName() -> [String] {
        let clz: AnyClass = Base.classForCoder()
        var listName = [String]()
        var count: UInt32 = 0
        guard let ivars = class_copyIvarList(clz, &count) else {
            return listName
        }
        for i in 0..<count {
            if let nameP = ivar_getName(ivars[Int(i)]) {
                let name = String(cString: nameP)
                listName.append(name)
            }
        }
        free(ivars)
        return listName
    }
    
    /// 获取所有属性的名字
    public static func propertiesName() -> [String] {
        let clz: AnyClass = Base.classForCoder()
        var propertyNames = [String]()
        var count = UInt32()
        guard let properties = class_copyPropertyList(clz, &count) else {
            return propertyNames
        }
        let intCount = Int(count)
        for i in 0 ..< intCount {
            let property: objc_property_t = properties[i]
            guard let propertyName = NSString(utf8String: property_getName(property)) as String? else {
                break
            }
            propertyNames.append(propertyName)
        }
        free(properties)
        return propertyNames
    }
    
    /// 获取方法列表
    public static func methodsList() -> [Selector] {
        let clz: AnyClass = Base.classForCoder()
        var methodNum: UInt32 = 0
        var list = [Selector]()
        guard let methods = class_copyMethodList(clz, &methodNum) else {
            return list
        }
        for index in 0..<numericCast(methodNum) {
            let met = methods[index]
            let selector = method_getName(met)
            list.append(selector)
        }
        free(methods)
        return list
    }
}

extension MKSwiftExtension where Base: NSObject {
    
    public func responds(to selector: Selector) -> Bool {
        if base.responds(to: selector) {
            return true
        }
        debugPrint("Failed responds to the selector: (\(selector)")
        return false
    }
}

// MARK: - Throttle

private var NSObjectThrottleAssociateKey: UInt8 = 0

extension NSObject {
    
    var throttleKeyValues: NSMutableDictionary {
        get {
            if let values = objc_getAssociatedObject(self, &NSObjectThrottleAssociateKey) as? NSMutableDictionary {
                return values
            }
            let values = NSMutableDictionary()
            objc_setAssociatedObject(self, &NSObjectThrottleAssociateKey, values, .OBJC_ASSOCIATION_RETAIN)
            return values
        }
    }
}


extension MKSwiftExtension where Base: NSObject {
    
    /// eg:
    /// @objc func testClick() {
    ///     mk.throttleFirstly(to: #function, throttleTime: 0.5) {
    ///         print("从点击到0.5秒的时间段，再次点击将会被拦截掉。")
    ///         writing..
    ///     }
    /// }
    
    /// 事件节流
    /// - Parameters:
    ///   - selector: 需要锁住指定的方法，需 `@objc ` 修饰.
    ///   - throttleTime: 节流时间
    ///   - excute: 执行代码块
    public func throttleFirstly(to selector: Selector, throttleTime: TimeInterval, excute: () -> Void) {
        if throttleTime <= 0 {
            excute()
            return
        }
        let fun = selector.description
        if let result = base.throttleKeyValues.value(forKey: fun) as? NSNumber, result.boolValue {
            return
        }
        excute()
        base.throttleKeyValues[fun] = NSNumber(value: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + throttleTime) { [weak base] in
            base?.throttleKeyValues[fun] = NSNumber(value: 0)
        }
    }
    
    /// 事件节流
    /// - Parameters:
    ///   - selector: 需要锁住指定的方法，需 `@objc ` 修饰.
    ///   - throttleTime: 节流时间
    ///   - excute: 执行代码块
    public func throttleLastly(to selector: Selector, throttleTime: TimeInterval, excute: @escaping () -> Void) {
        if throttleTime <= 0 {
            excute()
            return
        }
        let fun = selector.description
        if let result = base.throttleKeyValues.value(forKey: fun) as? NSNumber, result.boolValue {
            return
        }
        base.throttleKeyValues[fun] = NSNumber(value: 1)
        DispatchQueue.main.asyncAfter(deadline: .now() + throttleTime) { [weak base] in
            if base != nil {
                excute()
                base?.throttleKeyValues[fun] = NSNumber(value: 0)
            }
        }
    }
}
