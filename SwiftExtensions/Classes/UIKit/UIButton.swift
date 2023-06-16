//
//  UIButton.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

// MARK: - ImageLayout

extension MKSwiftExtension where Base: UIButton {
    
    public enum ImageLayout {
        case top
        case left
        case bottom
        case right
    }
    
    public func layout(_ layout: ImageLayout, spacing: CGFloat) {
        if layout == .left || layout == .right {
            let edgeOffset = spacing / 2
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: -edgeOffset, bottom: 0, right: edgeOffset)
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: -edgeOffset)
            if layout != .left {
                base.transform = CGAffineTransform(scaleX: -1, y: 1)
                base.imageView?.transform = CGAffineTransform(scaleX: -1, y: 1)
                base.titleLabel?.transform = CGAffineTransform(scaleX: -1, y: 1)
            }
            base.contentEdgeInsets = UIEdgeInsets(top: 0, left: edgeOffset, bottom: 0, right: edgeOffset)
        } else {
            guard let imageSize = base.imageView?.image?.size,
                  let text = base.titleLabel?.text,
                  let font = base.titleLabel?.font
            else { return }
            
            let labelString = NSString(string: text)
            let titleSize = labelString.size(withAttributes: [NSAttributedString.Key.font: font])
            
            let imageVerticalOffset = (titleSize.height + spacing)/2
            let titleVerticalOffset = (imageSize.height + spacing)/2
            let imageHorizontalOffset = (titleSize.width)/2
            let titleHorizontalOffset = (imageSize.width)/2
            let sign: CGFloat = (layout == .top) ? 1 : -1
            
            base.imageEdgeInsets = UIEdgeInsets(top: -imageVerticalOffset * sign,
                                           left: imageHorizontalOffset,
                                           bottom: imageVerticalOffset * sign,
                                           right: -imageHorizontalOffset)
            base.titleEdgeInsets = UIEdgeInsets(top: titleVerticalOffset * sign,
                                           left: -titleHorizontalOffset,
                                           bottom: -titleVerticalOffset * sign,
                                           right: titleHorizontalOffset)
            
            let edgeOffset = (min(imageSize.height, titleSize.height) + spacing)/2
            base.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0, bottom: edgeOffset, right: 0)
        }
    }
}


// MARK: - Expand EdgeInsets

fileprivate var UIButtonAssociationExpandEdgeInsetskey: UInt8 = 0
fileprivate var UIButtonAssociationExpandEdgeNormalkey: UInt8 = 0

extension UIButton {
    
    var expandEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, &UIButtonAssociationExpandEdgeInsetskey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            objc_getAssociatedObject(self, &UIButtonAssociationExpandEdgeInsetskey) as? UIEdgeInsets
        }
    }
    
    var expandEdgeNormal: Bool? {
        set {
            objc_setAssociatedObject(self, &UIButtonAssociationExpandEdgeNormalkey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
        get {
            objc_getAssociatedObject(self, &UIButtonAssociationExpandEdgeNormalkey) as? Bool
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        super.point(inside: point, with: event)
        var bounds = self.bounds
        var x: CGFloat = 0
        var y: CGFloat = 0
        var width: CGFloat = 0
        var height: CGFloat = 0
        if let expandEdgeInsets = expandEdgeInsets {
            x = -expandEdgeInsets.left
            y = -expandEdgeInsets.top
            width = bounds.width + expandEdgeInsets.left + expandEdgeInsets.right
            height = bounds.height + expandEdgeInsets.top + expandEdgeInsets.bottom
            bounds = CGRect(x: x, y: y, width: width, height: height)
        } else {
            if let expandEdgeNormal = expandEdgeNormal, expandEdgeNormal {
                if bounds.width < 44.0 {
                    x = -(44.0 - bounds.width) / 2.0
                    width = 44.0
                }
                if bounds.height < 44.0 {
                    y = -(44.0 - bounds.height) / 2.0
                    height = 44.0
                }
                bounds = CGRect(x: x, y: y, width: width, height: height)
            }
        }
        return bounds.contains(point)
    }
}

extension MKSwiftExtension where Base: UIButton {
    
    /// 优先级高于 `expandNormalResponseArea`
    public func expandEdgeInsets(_ insets: UIEdgeInsets) {
        base.expandEdgeInsets = insets
    }
    
    /// 根据人机交互体验，最小的点击区域应该不小于 44 * 44
    public func expandNormalResponseArea(_ open: Bool = true) {
        base.expandEdgeNormal = open
    }
}

