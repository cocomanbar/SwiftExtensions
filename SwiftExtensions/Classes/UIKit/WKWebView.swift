//
//  WKWebView.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit
import WebKit

extension MKSwiftExtension where Base: WKWebView {
    
    public func loadString(_ urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        loadURL(url)
    }
    
    public func loadURL(_ url: URL?) {
        guard let url = url else { return }
        let request = URLRequest(url: url)
        base.load(request)
    }
}
