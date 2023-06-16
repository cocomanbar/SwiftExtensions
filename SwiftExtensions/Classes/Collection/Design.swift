//
//  Design.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

/// 部分值需要在 `makeKeyAndVisible` 之后

/// 屏幕宽高
public let screen_width = UIScreen.main.bounds.width
public let screen_height = UIScreen.main.bounds.height

/// 获取状态栏高度
public var statusBarHeight: CGFloat {
    UIApplication.shared.statusBarFrame.height
}

/// 导航栏的高度
public var navigationBarHeight: CGFloat {
    44 + statusBarHeight
}

/// 安全区域
public var safeAreaEdgeInsets: UIEdgeInsets {
    if #available(iOS 11.0, *) {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    } else {
        return .zero
    }
}

/// 屏幕底部安全间距
public var safeBottomHeight: CGFloat {
    safeAreaEdgeInsets.bottom
}

/// 获取tabBar高度
public var tabBarHeight: CGFloat {
    safeBottomHeight + 44
}

/// 版本比较：小于?系统
public func systemVersionLessThan(_ target: Float) -> Bool {
    (Float(UIDevice.current.systemVersion) ?? 0) < target
}

/// 版本比较：小于或等于?系统
public func systemVersionLessThanOrEqualTo(_ target: Float) -> Bool {
    (Float(UIDevice.current.systemVersion) ?? 0) <= target
}

/// 版本比较：大?系统
public func systemVersionGreatThan(_ target: Float) -> Bool {
    (Float(UIDevice.current.systemVersion) ?? 0) > target
}

/// 版本比较：大于或等于?系统
public func systemVersionGreatThanOrEqualTo(_ target: Float) -> Bool {
    (Float(UIDevice.current.systemVersion) ?? 0) >= target
}

/// 是否是Retina屏
public var screenIsRetina: Bool {
    UIScreen.main.scale > 1
}

/// 宽度适配比例375
public var adjustableWidthScale: CGFloat {
    screen_width / 375.0
}

/// 高度适配比例667
public var adjustableHeightScale: CGFloat {
    screen_height / 667.0
}

/// 适配宽度
public func adjustableWidth(_ value: CGFloat) -> CGFloat {
    value * adjustableWidthScale
}

/// 适配高度
public func adjustableHeight(_ value: CGFloat) -> CGFloat {
    value * adjustableHeightScale
}

/// 绝对1像素
public var absoluteOnePixel: CGFloat {
    1.0 / UIScreen.main.scale
}
