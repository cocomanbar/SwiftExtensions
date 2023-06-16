//
//  NSMutableAttributedString.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

// MARK: - Setting like YYText

extension MKSwiftExtension where Base: NSMutableAttributedString {
    
    // MARK: - Set text attribute as property
    
    public func font(_ value: UIFont?, range: NSRange? = nil) {
        setAttribute(.font, value: value, range: range)
    }

    public func color(_ value: UIColor?, range: NSRange? = nil) {
        setAttribute(.foregroundColor, value: value, range: range)
    }
    
    public func backgroundColor(_ value: UIColor?, range: NSRange? = nil) {
        setAttribute(.backgroundColor, value: value, range: range)
    }
    
    public func strokeWidth(_ value: NSNumber?, range: NSRange? = nil) {
        setAttribute(.strokeWidth, value: value, range: range)
    }
    
    public func strokeColor(_ value: UIColor?, range: NSRange? = nil) {
        setAttribute(.strokeColor, value: value, range: range)
    }
    
    public func shadow(_ value: NSShadow?, range: NSRange? = nil) {
        setAttribute(.shadow, value: value, range: range)
    }

    public func kern(_ value: NSNumber?, range: NSRange? = nil) {
        setAttribute(.kern, value: value, range: range)
    }
    
    public func strikethroughStyle(_ value: NSUnderlineStyle?, range: NSRange? = nil) {
        setAttribute(.strikethroughStyle, value: value, range: range)
    }
    
    public func strikethroughColor(_ value: UIColor?, range: NSRange? = nil) {
        setAttribute(.strikethroughColor, value: value, range: range)
    }
    
    public func underlineStyle(_ value: NSUnderlineStyle?, range: NSRange? = nil) {
        setAttribute(.underlineStyle, value: value, range: range)
    }
    
    public func underlineColor(_ value: UIColor?, range: NSRange? = nil) {
        setAttribute(.underlineColor, value: value, range: range)
    }
    
    public func ligature(_ value: NSNumber?, range: NSRange? = nil) {
        setAttribute(.ligature, value: value, range: range)
    }
    
    public func textEffect(_ value: String?, range: NSRange? = nil) {
        setAttribute(.textEffect, value: value, range: range)
    }
    
    public func obliqueness(_ value: NSNumber?, range: NSRange? = nil) {
        setAttribute(.obliqueness, value: value, range: range)
    }
    
    public func expansion(_ value: NSNumber?, range: NSRange? = nil) {
        setAttribute(.expansion, value: value, range: range)
    }
    
    public func baselineOffset(_ value: NSNumber?, range: NSRange? = nil) {
        setAttribute(.baselineOffset, value: value, range: range)
    }
    
    public func paragraphStyle(_ value: NSParagraphStyle?, range: NSRange? = nil) {
        setAttribute(.paragraphStyle, value: value, range: range)
    }
    
    // MARK: - Set paragraph attribute as property
    
    public func alignment(_ value: NSTextAlignment = .natural, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, alignment: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func lineBreakMode(_ value: NSLineBreakMode = .byWordWrapping, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, lineBreakMode: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func lineSpacing(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, lineSpacing: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func paragraphSpacing(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, paragraphSpacing: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func paragraphSpacingBefore(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, paragraphSpacingBefore: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func firstLineHeadIndent(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, firstLineHeadIndent: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func headIndent(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, headIndent: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func tailIndent(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, tailIndent: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func minimumLineHeight(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, minimumLineHeight: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func maximumLineHeight(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, maximumLineHeight: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func lineHeightMultiple(_ value: CGFloat = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, lineHeightMultiple: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func baseWritingDirection(_ value: NSWritingDirection = .natural, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, baseWritingDirection: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func hyphenationFactor(_ value: Float = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, hyphenationFactor: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func defaultTabInterval(_ value: Float = 0, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, defaultTabInterval: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    public func tabStops(_ value: [NSTextTab]? = nil, range: NSRange? = nil) {
        MKSwiftMutableAttributeHelper.mutableAttribute(base, tabStops: value, range: range ?? NSMakeRange(0, base.length))
    }
    
    /// 快速添加和移除
    public func setAttribute(_ name: NSAttributedString.Key, value: Any?, range: NSRange?) {
        let range = range ?? NSRange(location: 0, length: base.length)
        if let value = value {
            base.addAttribute(name, value: value, range: range)
        } else {
            base.removeAttribute(name, range: range)
        }
    }
}
