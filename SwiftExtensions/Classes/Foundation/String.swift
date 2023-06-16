//
//  String.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import UIKit
import Foundation
import CommonCrypto

extension String: MKSwiftExtensionCompatibleValue {}

// MARK: - 截取字符串

public extension String {
    
    subscript(_ indexs: ClosedRange<Int>) -> String {
        if indexs.lowerBound >= 0 && indexs.lowerBound < count && indexs.upperBound >= 0 && indexs.upperBound < count {
            let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
            let endIndex = index(startIndex, offsetBy: indexs.upperBound)
            return String(self[beginIndex...endIndex])
        }
        return self
    }
    
    subscript(_ indexs: Range<Int>) -> String {
        if indexs.lowerBound >= 0 && indexs.lowerBound < count && indexs.upperBound >= 0 && indexs.upperBound < count {
            let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
            let endIndex = index(startIndex, offsetBy: indexs.upperBound)
            return String(self[beginIndex..<endIndex])
        }
        return self
    }
    
    subscript(_ indexs: PartialRangeThrough<Int>) -> String {
        if indexs.upperBound >= 0 && indexs.upperBound < count {
            let endIndex = index(startIndex, offsetBy: indexs.upperBound)
            return String(self[startIndex...endIndex])
        }
        return self
    }
    
    subscript(_ indexs: PartialRangeFrom<Int>) -> String {
        if indexs.lowerBound <= 0 {
            return self
        }
        let beginIndex = index(startIndex, offsetBy: indexs.lowerBound)
        return String(self[beginIndex..<endIndex])
    }
    
    subscript(_ indexs: PartialRangeUpTo<Int>) -> String {
        if indexs.upperBound >= count || indexs.upperBound < 0 {
            return self
        }
        let endIndex = index(startIndex, offsetBy: indexs.upperBound)
        return String(self[startIndex..<endIndex])
    }
}

extension MKSwiftExtension where Base == String {
    
    /// MD5
    public var md5: String {
        let utf8 = base.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    /// urlDecoding
    var urlDecoding: String {
        if base.isEmpty {
            return ""
        }
        guard let decoding = base.removingPercentEncoding else { return base }
        return decoding
    }
    
    /// urlEncoding
    var urlEncoding: String {
        if base.isEmpty {
            return ""
        }
        let decod = urlDecoding
        guard let encode = decod.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return decod }
        return encode
    }
    
    
}

// MARK: - 校验

extension MKSwiftExtension where Base == String {
    
    /// 校验手机号码
    public var isValidPhoneNum: Bool {
        regexJudge("^(13[0-9]|15[0-9]|18[0-9]|17[0-9]|147)\\d{8}$")
    }
    
    /// 校验邮箱
    public var isValidEmail: Bool {
        regexJudge("[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    }
    
    /// 校验身份证
    public var isIdCard: Bool {
        regexJudge("^(\\d{14}|\\d{17})(\\d|[xX])$")
    }
    
    /// 校验数字
    public var isValidNumber: Bool {
        regexJudge("^[0-9]+$")
    }
    
    /// 校验是否有中文
    public var validateExistChinese: Bool {
        regexJudge("^[\\u4e00-\\u9fa5]{2,10}")
    }
    
    /// 通用校验
    public func regexJudge(_ pattern: String) -> Bool {
        if base.count == 0 {
            return false
        }
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: base)
    }
}

// MARK: - 富文本

extension MKSwiftExtension where Base == String {
    
    /// 生成普通富文本
    public func attributeString(font: UIFont,
                                textColor: UIColor,
                                lineSpacing: CGFloat? = nil,
                                minimumLineHeight: CGFloat? = nil,
                                maximumLineHeight: CGFloat? = nil,
                                alignment: NSTextAlignment = .left,
                                lineBreakMode: NSLineBreakMode = .byWordWrapping) -> NSAttributedString {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineBreakMode = lineBreakMode
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
        }
        if let minimumLineHeight = minimumLineHeight {
            paragraphStyle.minimumLineHeight = minimumLineHeight
        }
        if let maximumLineHeight = maximumLineHeight {
            paragraphStyle.maximumLineHeight = maximumLineHeight
        }
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle
        ]
        return NSAttributedString(string: base, attributes: attributes)
    }
    
    /// html转富文本
    public func htmlAttribute(_ font: UIFont? = nil) -> NSMutableAttributedString? {
        if base.isEmpty {
            return nil
        }
        guard let data = base.data(using: .utf8) else { return nil }
        do {
            let attribute = try NSMutableAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding: NSUTF8StringEncoding], documentAttributes: nil)
            if let font = font {
                attribute.addAttribute(.font, value: font, range: NSRange(location: 0, length: attribute.length))
            }
            return attribute
        } catch {}
        return nil
    }
    
    /// 计算普通文本Size
    public func boundingRect(with size: CGSize, attributes: [NSAttributedString.Key: Any]) -> CGSize {
        (base as NSString).boundingRect(with: size, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: attributes, context: nil).size
    }
    
    /// 计算普通文本Height
    public func boundingHeight(with maxWidth: CGFloat, font: UIFont?, lineHeight: CGFloat?, lineSpacing: CGFloat?) -> CGFloat {
        var attributes = [NSAttributedString.Key: Any]()
        if let font = font {
            attributes[.font] = font
        }
        let paragraphStyle = NSMutableParagraphStyle()
        if let lineHeight = lineHeight {
            paragraphStyle.minimumLineHeight = lineHeight
            attributes[.paragraphStyle] = paragraphStyle
        }
        if let lineSpacing = lineSpacing {
            paragraphStyle.lineSpacing = lineSpacing
            attributes[.paragraphStyle] = paragraphStyle
        }
        return boundingRect(with: CGSize(width: maxWidth, height: .greatestFiniteMagnitude), attributes: attributes).height
    }
}
