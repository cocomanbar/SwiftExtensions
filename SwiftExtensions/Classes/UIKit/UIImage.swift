//
//  UIImage.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

// MARK: - Instance

extension MKSwiftExtension where Base: UIImage {
    
    /// 制作圆角
    public func radius(_ radius: CGFloat, corners: UIRectCorner = .allCorners) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, true, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.white.cgColor)
        context?.fill(rect)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        context?.addPath(path)
        context?.clip()
        base.draw(in: rect)
        context?.drawPath(using: .fillStroke)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    
    /// 中间拉伸使周边不形变
    public func resizeImage() -> UIImage {
        base.stretchableImage(withLeftCapWidth: Int(base.size.width * 0.5), topCapHeight: Int(base.size.height * 0.5))
    }
    
    /// 使用原始图片，不进行额外渲染
    public func originalImage() -> UIImage {
        base.withRenderingMode(.alwaysOriginal)
    }
    
    /// toJPEG
    public func toJPEG(_ quarity: CGFloat = 1.0) -> Data? {
        base.jpegData(compressionQuality: quarity)
    }
    
    /// toPNG
    public func toPNG() -> Data? {
        base.pngData()
    }
    
    /// base64 string
    public var base64: String? {
        toJPEG()?.base64EncodedString()
    }
    
    /// 根据宽度换算出高度
    public func aspectHeightForWidth(_ width: CGFloat) -> CGFloat {
        if base.size.width == 0 {
            return 0
        }
        return (width * base.size.height) / base.size.width
    }
    
    /// 根据高度换算出宽度
    public func aspectWidthForHeight(_ height: CGFloat) -> CGFloat {
        if base.size.height == 0 {
            return 0
        }
        return (height * base.size.width) / base.size.height
    }
}

extension MKSwiftExtension where Base: UIImage {
    
    /// 生成图片富文本，可选限制宽或高
    public func attachmentAttribute(with alignToFont: UIFont? = nil,
                                    limitHeight: CGFloat? = nil,
                                    limitWidth: CGFloat? = nil,
                                    alignment: NSTextAlignment? = nil) -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = base
        var width: CGFloat = base.size.width
        var height: CGFloat = base.size.height
        if let limitHeight = limitHeight, height != 0 {
            width = (width / height) * limitHeight
        }
        if let limitWidth = limitWidth, width != 0 {
            height = (height / width) * limitWidth
        }
        attachment.bounds = CGRect(x: 0, y: 0, width: width, height: height)
        let attachmentAttribute = NSMutableAttributedString(attachment: attachment)
        if let alignment = alignment {
            let style = NSMutableParagraphStyle()
            style.alignment = alignment
            attachmentAttribute.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: attachmentAttribute.length))
        }
        if let alignToFont = alignToFont {
            attachmentAttribute.addAttribute(.font, value: alignToFont, range: NSRange(location: 0, length: attachmentAttribute.length))
        }
        return attachmentAttribute
    }
    
    /// 添加水印
    public func drawImage(_ image: UIImage,  at frame: CGRect) -> UIImage? {
        UIGraphicsBeginImageContext(base.size)
        base.draw(in: CGRect.init(x: 0, y: 0, width: base.size.width, height: base.size.height))
        image.draw(in: frame)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}

// MARK: - Static

extension MKSwiftExtension where Base: UIImage {
    
    /// 生成指定颜色图片
    public static func image(forColor color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        var image: UIImage?
        UIGraphicsBeginImageContext(rect.size)
        repeat {
            guard let context = UIGraphicsGetCurrentContext() else {
                break
            }
            context.setFillColor(color.cgColor)
            context.fill(rect)
            image = UIGraphicsGetImageFromCurrentImageContext()
            image = image?.resizableImage(withCapInsets: .zero, resizingMode: .tile)
        } while (false)
        UIGraphicsEndImageContext()
        return image
    }
}

// MARK: - Load Image

extension MKSwiftExtension where Base: UIImage {
    
    /// 加载图片
    public static func imageName(_ named: String) -> UIImage? {
        if named.isEmpty {
            return nil
        }
        return Base(named: named)
    }
    
    /// 加载图片，不涉及缓存
    public static func imageTempName(_ named: String, in bundle: Bundle? = nil) -> UIImage? {
        let bundle = bundle ?? Bundle.main
        let path = (bundle.bundlePath as NSString).appendingPathComponent(named)
        return Base.init(contentsOfFile: path)
    }
}
