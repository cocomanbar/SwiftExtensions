//
//  URL.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension URL: MKSwiftExtensionCompatibleValue {}

extension MKSwiftExtension where Base == URL {
    
    public func openURL(options: [UIApplication.OpenExternalURLOptionsKey : Any] = [:],
                        completionHandler: ((Bool) -> Void)?) {
        if UIApplication.shared.canOpenURL(base) {
            UIApplication.shared.open(base, options: options, completionHandler: completionHandler)
        }
    }
}
