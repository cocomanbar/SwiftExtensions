//
//  IndexPath.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension IndexPath: MKSwiftExtensionCompatibleValue {}

extension MKSwiftExtension where Base == IndexPath {
    
    public var previousRow: IndexPath {
        if base.row == 0 {
            return base
        }
        return IndexPath(row: base.row - 1, section: base.section)
    }
    
    public var nextRow: IndexPath {
        IndexPath(row: base.row + 1, section: base.section)
    }
    
    public var previousSection: IndexPath {
        if base.section == 0 {
            return base
        }
        return IndexPath(row: base.row, section: base.section - 1)
    }
    
    public var nextSection: IndexPath {
        IndexPath(row: base.row, section: base.section + 1)
    }
}
