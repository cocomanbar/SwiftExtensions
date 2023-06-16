//
//  UIDevice.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit
import AudioToolbox

// MARK: - static

extension MKSwiftExtension where Base: UIDevice {
    
    public static var isPad: Bool {
        Base.current.userInterfaceIdiom == .pad
    }
    
    public static var isPhone: Bool {
        Base.current.userInterfaceIdiom == .phone
    }
    
    @available(iOS 14.0, *)
    public static var isMac: Bool {
        Base.current.userInterfaceIdiom == .mac
    }
    
    public static var isCarPlay: Bool {
        Base.current.userInterfaceIdiom == .carPlay
    }
    
    public static var isTV: Bool {
        Base.current.userInterfaceIdiom == .tv
    }
}

extension MKSwiftExtension where Base: UIDevice {
    
    /// 系统版本
    public static var systemVersion: String {
        Base.current.systemVersion
    }
    
    /// 系统更新时间
    public static var systemUptime: Date {
        let time = ProcessInfo.processInfo.systemUptime
        return Date(timeIntervalSinceNow: 0 - time)
    }
    
    /// 设备类型
    public static var deviceType: String {
        Base.current.model
    }
    
    /// 系统名称
    public static var systemName: String {
        Base.current.systemName
    }
    
    /// 设备名称
    public static var deviceName: String {
        Base.current.name
    }
    
    /// 设备型号
    public static var deviceModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machine = systemInfo.machine
        var identifier = ""
        let mirror = Mirror(reflecting: machine)
        for child in mirror.children {
            let value = child.value
            if let value = value as? Int8, value != 0 {
                identifier.append(String(UnicodeScalar(UInt8(value))))
            }
        }
        return identifier
    }
    
    /// 设备是不是模拟器
    public static var isSimulator: Bool {
        var ret = false
        #if arch(i386) || arch(x86_64)
        ret = true
        #endif
        return ret
    }
    
    /// 设备UUID
    public static var uuid: String? {
        let uuid = CFUUIDCreate(kCFAllocatorDefault)
        let cfString = CFUUIDCreateString(kCFAllocatorDefault, uuid)
        return cfString as String?
    }
    
    /// 是否越狱
    public static var isBroken: Bool {
        if isSimulator { return false }
        let paths = ["/Applications/Cydia.app", "/private/var/lib/apt/",
                     "/private/var/lib/cydia", "/private/var/stash"]
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        let bash = fopen("/bin/bash", "r")
        if bash != nil {
            fclose(bash)
            return true
        }
        let path = String(format: "/private/%@", uuid ?? "")
        do {
            try "broken.".write(toFile: path, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            
        }
        return false
    }
    
    /// 当前磁盘空间
    public static var diskSpace: Int64? {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let space: NSNumber = attrs[FileAttributeKey.systemSize] as? NSNumber {
                if space.int64Value > 0 {
                    return space.int64Value
                }
            }
        }
        return nil
    }
    
    /// 当前磁盘可用空间
    public static var diskSpaceFree: Int64? {
        if let attrs = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            if let space: NSNumber = attrs[FileAttributeKey.systemFreeSize] as? NSNumber {
                if space.int64Value > 0 {
                    return space.int64Value
                }
            }
        }
        return nil
    }
    
    /// 硬盘已经使用的空间
    public static var diskSpaceUsed: Int64? {
        let total = diskSpace ?? 0
        let free = diskSpaceFree ?? 0
        guard total > 0 && free > 0 else { return nil }
        let used = total - free
        guard used > 0 else { return nil }
        return used
    }
    
    /// 获取总内存大小
    public static var deviceMemory: Int64 {
        Int64(ProcessInfo.processInfo.physicalMemory)
    }
}

// MARK: - 震动

extension MKSwiftExtension where Base: UIDevice {
    
    public static func systemSoundID(_ id: UInt32) {
        let soundShort = SystemSoundID(id)
        AudioServicesPlaySystemSound(soundShort)
    }
}
