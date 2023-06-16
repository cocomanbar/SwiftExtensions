//
//  UIAlertController.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UIAlertController {
    
    public func addAction(_ title: String,
                          actionStyle: UIAlertAction.Style = .default,
                          handler: ( (UIAlertAction) -> Void)?)
    {
        let action = UIAlertAction(title: title, style: actionStyle, handler: handler)
        base.addAction(action)
    }
    
    public func alert(_ controller: UIViewController? = nil, animated: Bool = true) {
        
        let defaultRoot = controller ?? UIApplication.shared.keyWindow?.rootViewController
        DispatchQueue.main.async {
            defaultRoot?.present(base, animated: animated)
        }
    }
}
