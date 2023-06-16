//
//  UIStoryboard.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation
import UIKit

extension MKSwiftExtension where Base: UIStoryboard {
    
    public static var main: UIStoryboard? {
        guard let name = Bundle.main.object(forInfoDictionaryKey: "UIMainStoryboardFile") as? String else { return nil }
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
}

extension MKSwiftExtension where Base: UIStoryboard {
    
    public func instantiate<T>(_ identifier: T.Type) -> T? {
        let id = String(describing: identifier)
        guard let controller = base.instantiateViewController(withIdentifier: id) as? T else { return nil }
        return controller
    }
}
