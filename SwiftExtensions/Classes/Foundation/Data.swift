//
//  Data.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension MKSwiftExtension where Base == Data {
    
    /// 编码
    public var encodeToData: Data? {
        base.base64EncodedData()
    }
    
    /// 解码
    public var decodeToDada: Data? {
        Data(base64Encoded: base)
    }
    
    /// 转成bytes
    public var bytes: [UInt8] {
        [UInt8](base)
    }
}
