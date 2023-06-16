//
//  NSAttributedString.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

// MARK: - Static

extension MKSwiftExtension where Base: NSAttributedString {
    
    /// 根据宽度计算高度
    public func height(for width: CGFloat) -> CGFloat {
        base.boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size.height
    }
    
    /// 根据高度计算宽度
    public func width(for height: CGFloat) -> CGFloat {
        base.boundingRect(with: CGSize(width: CGFloat.greatestFiniteMagnitude, height: height), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil).size.width
    }
    
    /// 根据宽度计算出每行的内容
    /// 注意 `NSLineBreakMode` 需要设置为 `.byWordWrapping` 或 `.byCharWrapping` 才可以得到全部的准确内容
    public func lines(_ width: CGFloat) -> [NSAttributedString] {
        let attribute: NSMutableAttributedString = base.mutableCopy() as! NSMutableAttributedString
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attribute)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: Int(width), height: Int.max))
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: 0), path, nil)
        let lines: [CTLine] = CTFrameGetLines(frame) as! [CTLine]
        var attributes = [NSAttributedString]()
        for line in lines {
            let lineCFRange: CFRange = CTLineGetStringRange(line)
            let lineNSRange: NSRange = NSRange(location: lineCFRange.location, length: lineCFRange.length)
            let lineString: NSAttributedString = attribute.attributedSubstring(from: lineNSRange)
            attributes.append(lineString)
        }
        return attributes
    }
    
    /// 根据宽度计算出行数
    /// 注意 `NSLineBreakMode` 需要设置为 `.byWordWrapping` 或 `.byCharWrapping` 才可以得到全部内容的准确行数
    public func lineCount(_ width: CGFloat) -> Int {
        if base.length == 0 {
            return 0
        }
        let attribute: NSMutableAttributedString = base.mutableCopy() as! NSMutableAttributedString
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attribute)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: Int(width), height: Int.max))
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRange(location: 0, length: 0), path, nil)
        let lines: [CTLine] = CTFrameGetLines(frame) as! [CTLine]
        return lines.count
    }
}
