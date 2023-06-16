//
//  FileManager.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: FileManager {
    
    public var homeDirectory: String {
        NSHomeDirectory()
    }
    
    public var documentPath: String {
        NSHomeDirectory() + "/Documents"
    }
    
    public var libraryPath: String {
        NSHomeDirectory() + "/Library"
    }
    
    public var cachePath: String {
        NSHomeDirectory() + "/Library/Caches"
    }
    
    public var tempPath: String {
        NSHomeDirectory() + "/tmp"
    }
    
}

extension MKSwiftExtension where Base: FileManager {
    
    /// 创建文件夹
    @discardableResult
    public static func createFolderIfNeeded(_ path: String?,
                                            createIntermediates: Bool = true,
                                            attributes: [FileAttributeKey: Any]? = nil) -> Bool {
        guard let path = path else { return false }
        var isDirectory = ObjCBool(false)
        let isExist = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        if !isExist || !isDirectory.boolValue {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: createIntermediates, attributes: attributes)
            } catch {
                return false
            }
        }
        return true
    }
    
    /// 创建文件
    @discardableResult
    public static func createFileAtPath(_ path: String?) -> Bool {
        guard let path = path else { return false }
        var isDirectory = ObjCBool(false)
        let isExists = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        if !isExists || isDirectory.boolValue {
            return FileManager.default.createFile(atPath: path, contents: nil)
        }
        return false
    }
    
    /// 删除文件夹
    @discardableResult
    public static func deleteDirectoryAtPath(_ path: String?) -> Bool {
        guard let path = path else { return false }
        var isDirectory = ObjCBool(false)
        let result = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        if result && isDirectory.boolValue {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                return false
            }
        }
        return true
    }
    
    /// 删除文件
    @discardableResult
    public static func deleteFile(_ path: String?) -> Bool {
        guard let path = path else { return false }
        var isDirectory = ObjCBool(false)
        let result = FileManager.default.fileExists(atPath: path, isDirectory: &isDirectory)
        if result && !isDirectory.boolValue {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                return false
            }
        }
        return true
    }
    
    /// 文件大小
    public static func sizeAtFile(_ path: String?) -> Int64 {
        guard let path = path else { return 0 }
        guard let attributes = try? FileManager.default.attributesOfItem(atPath: path) else { return 0 }
        if let size = attributes[.size] as? Int64 {
            return size
        }
        return 0
    }
}

