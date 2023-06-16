//
//  UIResponder.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

public protocol MKRouter {
    func forwardable(_ event: String, with parameters: Any?)
}

extension UIResponder: MKRouter {
    
    @objc open func forwardable(_ event: String, with parameters: Any?) {
        next?.forwardable(event, with: parameters)
    }
}
