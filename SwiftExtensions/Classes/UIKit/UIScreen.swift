//
//  UIScreen.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UIScreen {
    
    /// UIScreen.Bounds
    public static var Bounds: CGRect {
        Base.main.bounds
    }
    
    /// UIScreen.Size
    public static var Size: CGSize {
        Bounds.size
    }
    
    /// UIScreen.Width
    public static var Width: CGFloat {
        Size.width
    }
    
    /// UIScreen.Height
    public static var Height: CGFloat {
        Size.height
    }
    
    /// UIScreen.Scale
    public static var Scale: CGFloat {
        Base.main.scale
    }
    
    /// UIScreen.SafeAreaInsets
    public static var safeAreaInsets: UIEdgeInsets {
        let window: UIWindow = UIApplication.shared.keyWindow ?? UIWindow()
        if #available(iOS 11.0, *) {
            return window.safeAreaInsets
        } else {
            return .zero
        }
    }
    
    /// UIScreen.StatusBarHeight
    public static var StatusBarHeight: CGFloat {
        UIApplication.shared.statusBarFrame.height
    }
    
    /// UIScreen.NavigationBarHeight
    public static var NavigationBarHeight: CGFloat {
        StatusBarHeight + 44.0
    }
    
    /// UIScreen.TabBarHeight
    public static var TabBarHeight: CGFloat {
        safeAreaInsets.bottom + 49.0
    }
}

