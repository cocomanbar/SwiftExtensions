//
//  Synchronized.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

/// 加锁
public func synchronized(lock: AnyObject, work: () -> Void) {
    objc_sync_enter(lock)
    work()
    objc_sync_exit(lock)
}
