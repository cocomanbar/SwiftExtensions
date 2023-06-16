//
//  Bundle.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension MKSwiftExtension where Base == Bundle {
    
    public var shortVersionString: String? {
        base.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    public var version: String? {
        base.infoDictionary?["CFBundleVersion"] as? String
    }
}

