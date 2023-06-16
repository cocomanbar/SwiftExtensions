//
//  UIApplication.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UIApplication {
    
    /// 打开链接
    public static func openURL(_ url: URL?,
                               options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:],
                               completion: ((Bool) -> Void)? = nil)
    {
        guard let url = url, UIApplication.shared.canOpenURL(url) else {
            completion?(false)
            return
        }
        UIApplication.shared.open(url, options: options, completionHandler: completion)
    }
    
    /// 打开设置
    public static func openSetting(_ completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: Base.openSettingsURLString) else { return }
        openURL(url, completion: completion)
    }
    
    /// 打开商店
    public static func openStore(_ id: String, completion: ((Bool) -> Void)? = nil) {
        guard let url = URL(string: "https://itunes.apple.com/cn/lookup?id=\(id)") else {
            completion?(false)
            return
        }
        openURL(url, completion: completion)
    }
    
    /// 设置常亮
    public static func isIdleTimerDisabled(_ isIdleTimerDisabled: Bool) {
        UIApplication.shared.isIdleTimerDisabled = isIdleTimerDisabled
    }
    
    /// 主动退出
    public static func exitApp() {
        abort()
    }
}
