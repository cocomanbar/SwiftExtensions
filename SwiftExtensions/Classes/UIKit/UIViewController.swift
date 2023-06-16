//
//  UIViewController.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UIViewController {
    
    public func topPresented() -> UIViewController? {
        guard var presentedViewController = base.presentedViewController else {
            return nil
        }
        while presentedViewController.presentedViewController != nil {
            presentedViewController = presentedViewController.presentedViewController!
        }
        return presentedViewController
    }
    
    public var isVisible: Bool {
        base.isViewLoaded && base.view.window != nil
    }
}
