//
//  UITextView.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

// MARK: - Placeholder-Label

class PlaceholderLabel: UILabel {
    
    var placeholderInsets: UIEdgeInsets?
    
    static let tag: Int = 1056
    
    weak var textView: UITextView? {
        didSet {
            if let textView = textView {
                textView.addObserver(self, forKeyPath: "text", options: [.old, .new], context: nil)
                textView.addObserver(self, forKeyPath: "frame", options: [.old, .new], context: nil)
                NotificationCenter.default.addObserver(forName: UITextView.textDidChangeNotification,
                                                       object: nil, queue: OperationQueue.main)
                { [weak self] notif in
                    if let obj = notif.object as? UITextView, obj.isEqual(textView) {
                        self?.didChangeText()
                    }
                }
            }
        }
    }
    
    func resizeLayout() {
        guard let textView = textView, !CGRectIsEmpty(textView.frame) else { return }
        
        var textInsets: UIEdgeInsets = .zero
        if let placeholderInsets = placeholderInsets {
            textInsets = placeholderInsets
        } else {
            textInsets = textView.textContainerInset
            textInsets.left = textView.textContainer.lineFragmentPadding
            textInsets.right = textView.textContainer.lineFragmentPadding
        }
        var willSetFrame = textView.bounds
        willSetFrame.origin.x = textInsets.left
        willSetFrame.origin.y = textInsets.top
        willSetFrame.size.width = willSetFrame.size.width - textInsets.left - textInsets.right
        let maxHeight = willSetFrame.height - textInsets.top - textInsets.bottom
        let height = attributedText?.boundingRect(with: CGSize(width: willSetFrame.size.width, height: CGFloat.greatestFiniteMagnitude), options: [.usesLineFragmentOrigin, .usesFontLeading],context: nil).size.height ?? 0
        willSetFrame.size.height = min(maxHeight, height)
        frame = willSetFrame
        lineBreakMode = height > maxHeight ? .byTruncatingTail : .byWordWrapping
    }
    
    // textView.text
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "text" {
            didChangeText()
        } else if keyPath == "frame" {
            resizeLayout()
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }
    
    // ChangeText
    func didChangeText() {
        isHidden = (textView?.text.count ?? 0) > 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        if let textView = textView {
            textView.removeObserver(self, forKeyPath: "text")
            textView.removeObserver(self, forKeyPath: "frame")
        }
    }
}

extension MKSwiftExtension where Base: UITextView {
    
    public var attributedPlaceholder: NSAttributedString? {
        set {
            if let label = base.viewWithTag(PlaceholderLabel.tag) as? PlaceholderLabel {
                label.attributedText = newValue
                label.resizeLayout()
            } else {
                let label = PlaceholderLabel()
                label.isHidden = base.text.count > 0
                label.textView = base
                label.tag = PlaceholderLabel.tag
                label.attributedText = newValue
                label.numberOfLines = 0
                base.addSubview(label)
                base.bringSubviewToFront(label)
                label.resizeLayout()
            }
        }
        get {
            if let label = base.viewWithTag(PlaceholderLabel.tag) as? PlaceholderLabel {
                return label.attributedText
            }
            return nil
        }
    }
    
    public var attributedPlaceholderInset: UIEdgeInsets? {
        get {
            if let label = base.viewWithTag(PlaceholderLabel.tag) as? PlaceholderLabel {
                return label.placeholderInsets
            }
            return nil
        }
        set {
            if let label = base.viewWithTag(PlaceholderLabel.tag) as? PlaceholderLabel {
                label.placeholderInsets = newValue
                label.resizeLayout()
            } else {
                assert(false, "Please set mk.attributedPlaceholder before, 😄")
            }
        }
    }
}

// MARK: - Scroll To Visible

extension MKSwiftExtension where Base: UITextView {
    
    public func scrollToBottom() {
        var range: NSRange?
        if base.text.count > 0 {
            range = NSRange(location: base.text.count - 1, length: 1)
        }
        guard let range = range else { return }
        base.scrollRangeToVisible(range)
    }
    
    public func scrollToTop() {
        var range: NSRange?
        if base.text.count > 0 {
            range = NSRange(location: 0, length: 1)
        }
        guard let range = range else { return }
        base.scrollRangeToVisible(range)
    }
}
