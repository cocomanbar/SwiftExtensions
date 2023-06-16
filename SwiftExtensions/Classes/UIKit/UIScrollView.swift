//
//  UIScrollView.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

fileprivate var UIScrollViewAssociationkey: UInt8 = 0

// MARK: - UIScrollView Extension

public extension UIScrollView {
    
    class StatusProperty: NSObject {
        fileprivate weak var scrollView: UIScrollView?
        
        public var lastSize: CGSize?
        public var lastOffset: CGPoint?
        public var lastInset: UIEdgeInsets?
        
        public var lastOffsetX: CGFloat?
        public var lastOffsetY: CGFloat?
    }
    
    var statusProperty: StatusProperty {
        if let status = objc_getAssociatedObject(self, &UIScrollViewAssociationkey) as? StatusProperty {
            return status
        }
        let status = StatusProperty()
        objc_setAssociatedObject(self, &UIScrollViewAssociationkey, status, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        status.scrollView = self
        return status
    }
}


// MARK: - UIScrollView

extension MKSwiftExtension where Base: UIScrollView {
    
    /// 快照图片
    public var snapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.contentSize, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        let previousFrame = base.frame
        base.frame = CGRect(origin: base.frame.origin, size: base.contentSize)
        base.layer.render(in: context)
        base.frame = previousFrame
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// 关闭自动偏移
    public func closedAdjustContentInsets() {
        if #available(iOS 11.0, *) {
            base.contentInsetAdjustmentBehavior = .never
        }
    }
    
    public func scrollToTop(animated: Bool = true) {
        base.setContentOffset(CGPoint(x: base.contentOffset.x, y: -base.contentInset.top), animated: animated)
    }
    
    public func scrollToLeft(animated: Bool = true) {
        base.setContentOffset(CGPoint(x: -base.contentInset.left, y: base.contentOffset.y), animated: animated)
    }
    
    func scrollToBottom(animated: Bool = true) {
        base.setContentOffset(
            CGPoint(x: base.contentOffset.x,
                    y: max(0, base.contentSize.height - base.bounds.height) + base.contentInset.bottom),
            animated: animated)
    }
    
    func scrollToRight(animated: Bool = true) {
        base.setContentOffset(
            CGPoint(x: max(0, base.contentSize.width - base.bounds.width) + base.contentInset.right,
                    y: base.contentOffset.y),
            animated: animated)
    }
}
