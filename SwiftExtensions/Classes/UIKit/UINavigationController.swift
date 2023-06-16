//
//  UINavigationController.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UINavigationController {
    
    public func bottomLineImageView() -> UIView? {
        func handleImageView(_ aView: UIView?) -> UIView? {
            guard let aView = aView else { return nil }
            if aView is UIImageView, aView.frame.size.height <= 1.0 {
                return aView
            }
            for view in aView.subviews {
                guard let imageView = handleImageView(view) else {
                    continue
                }
                if imageView is UIImageView, imageView.frame.size.height <= 1.0 {
                    return imageView
                }
            }
            return nil
        }
        return handleImageView(base.navigationBar)
    }
    
    public func push(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        base.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}

extension MKSwiftExtension where Base: UINavigationController {
    
    public static func current() -> UINavigationController? {
        guard let root = UIApplication.shared.delegate?.window??.rootViewController as? UIViewController else {
            return nil
        }
        if let navigationController = root.mk.topPresented() as? UINavigationController {
            return navigationController
        }
        if let tabBarController = root as? UITabBarController,
           let navigationController = tabBarController.selectedViewController as? UINavigationController {
            return navigationController
        }
        if let navigationController = root as? UINavigationController {
            return navigationController
        }
        return root.navigationController
    }
}
