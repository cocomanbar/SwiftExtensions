//
//  DispatchQueue.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import Dispatch

private var _onceTrackers = [String]()

extension MKSwiftExtension where Base: DispatchQueue {
    
    /// 安全的同步调用
    public func syncSafe(_ execute: () -> Void) {
        if base.label == String(cString: __dispatch_queue_get_label(nil)) {
            execute()
            return
        }
        base.sync(execute: execute)
    }
    
    /// 安全的异步调用
    public func asyncSafe(_ execute: @escaping () -> Void) {
        if base === DispatchQueue.main && Thread.isMainThread {
            execute()
        } else {
            base.async(execute: execute)
        }
    }
    
    /// 函数只被执行一次
    public static func once(token: String, execute: () -> Void) {
        if _onceTrackers.contains(token) {
            return
        }
        _onceTrackers.append(token)
        objc_sync_enter(self)
        defer {
            objc_sync_exit(self)
        }
        execute()
    }
    
    /// main延迟
    public static func asyncAfter(_ seconds: TimeInterval, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }
}
