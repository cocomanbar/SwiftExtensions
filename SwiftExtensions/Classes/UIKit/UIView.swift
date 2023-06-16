//
//  UIView.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

// MARK: - UIGestureRecognizer

fileprivate var UIViewAssociationkey: UInt8 = 0

public typealias MKGestureActionClosure = (UIGestureRecognizer) -> Void

fileprivate class MKGestureActionObjc: NSObject {
    weak var view: UIView?
    var gestureCallback: MKGestureActionClosure?
    @objc func gestureAction(gesture: UIGestureRecognizer) {
        gestureCallback?(gesture)
    }
}

public extension UIView {
    
    fileprivate var gestureActionObjc: MKGestureActionObjc {
        if let objc = objc_getAssociatedObject(self, &UIViewAssociationkey) as? MKGestureActionObjc {
            return objc
        }
        let objc = MKGestureActionObjc()
        objc_setAssociatedObject(self, &UIViewAssociationkey, objc, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        objc.view = self
        return objc
    }
}

extension MKSwiftExtension where Base: UIView {
    
    /// 添加点击手势
    @discardableResult public func tap(action: MKGestureActionClosure?) -> UITapGestureRecognizer? {
        add(gesture: UITapGestureRecognizer.self, action: action)
    }
    
    /// 添加滑动手势
    @discardableResult public func pan(action: MKGestureActionClosure?) -> UIPanGestureRecognizer? {
        add(gesture: UIPanGestureRecognizer.self, action: action)
    }
    
    /// 泛型添加手势
    @discardableResult public func add<T: UIGestureRecognizer>(gesture: T.Type, action: MKGestureActionClosure?) -> T? {
        
        if !base.isUserInteractionEnabled {
            assertionFailure("User interaction disable!\n\(self)")
            return nil
        }
        base.gestureActionObjc.gestureCallback = action
        let gestureRecognizer = T(target: base.gestureActionObjc, action: #selector(MKGestureActionObjc.gestureAction(gesture:)))
        base.addGestureRecognizer(gestureRecognizer)
        return gestureRecognizer
    }
}

// MARK: - Corner

extension MKSwiftExtension where Base: UIView {
    
    /// 圆角
    public func corner(_ radius: CGFloat,
                       rectCorner: UIRectCorner = .allCorners,
                       clip: Bool = true)
    {
        base.layer.cornerRadius = radius
        base.layer.maskedCorners = CACornerMask(rawValue: rectCorner.rawValue)
        base.layer.masksToBounds = clip
    }
    
    /// 圆角和阴影
    public func cornerShadow(_ shadowColor: UIColor,
                             shadowRadius: CGFloat,
                             shadowOpacity: Float = 1.0,
                             shadowOffset: CGSize = .zero,
                             cornerRadius: CGFloat = 0)
    {
        base.layer.cornerRadius = cornerRadius
        base.layer.shadowOffset = shadowOffset
        base.layer.shadowOpacity = shadowOpacity
        base.layer.shadowRadius = shadowRadius
        base.layer.shadowColor = shadowColor.cgColor
    }
    
}

// MARK: - Frame

extension MKSwiftExtension where Base: UIView {
    
    public var minX: CGFloat {
        get {
            base.frame.minX
        }
        set {
            var frame = base.frame
            frame.origin.x = newValue
            base.frame = frame
        }
    }
    
    public var minY: CGFloat {
        get {
            base.frame.midY
        }
        set {
            var frame = base.frame
            frame.origin.y = newValue
            base.frame = frame
        }
    }
    
    public var maxX: CGFloat {
        get {
            base.frame.maxX
        }
        set {
            var frame = base.frame
            frame.origin.x = newValue - frame.width
            base.frame = frame
        }
    }
    
    public var maxY: CGFloat {
        get {
            base.frame.maxY
        }
        set {
            var frame = base.frame
            frame.origin.y = newValue - frame.height
            base.frame = frame
        }
    }
    
    public var width: CGFloat {
        get {
            base.frame.width
        }
        set {
            var frame = base.frame
            frame.size.width = newValue
            base.frame = frame
        }
    }
    
    public var height: CGFloat {
        get {
            base.frame.height
        }
        set {
            var frame = base.frame
            frame.size.height = newValue
            base.frame = frame
        }
    }
    
    public var centerX: CGFloat {
        get {
            base.center.x
        }
        set {
            base.center = CGPoint(x: newValue, y: base.center.y)
        }
    }
    
    public var centerY: CGFloat {
        get {
            base.center.y
        }
        set {
            base.center = CGPoint(x: base.center.x, y: newValue)
        }
    }
    
    public var size: CGSize {
        get {
            base.frame.size
        }
        set {
            var frame = base.frame
            frame.size = newValue
            base.frame = frame
        }
    }
    
    public var origin: CGPoint {
        get {
            base.frame.origin
        }
        set {
            var frame = base.frame
            frame.origin = newValue
            base.frame = frame
        }
    }
}


// MARK: - Others

extension MKSwiftExtension where Base: UIView {
    
    /// 移除所有子view
    public func removeAll() {
        base.subviews.forEach { $0.removeFromSuperview() }
    }
    
    /// 截图
    public var shotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        base.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 控制器
    public var viewController: UIViewController? {
        var parent: UIResponder? = base
        while parent != nil {
            parent = parent?.next
            if let viewController = parent as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    /// 当前是否在屏幕内可见
    public var isOnScreen: Bool {
        guard let rootView = UIApplication.shared.keyWindow else {
            return false
        }
        let viewFrameInRootView = rootView.convert(base.frame, from: base.superview)
        return rootView.bounds.intersects(viewFrameInRootView)
    }
}
