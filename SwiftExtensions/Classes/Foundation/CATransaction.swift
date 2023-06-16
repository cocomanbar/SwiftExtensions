//
//  CATransaction.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

extension MKSwiftExtension where Base: CATransaction {
    
    static func perform(excute: () -> Void, completion: (() -> Void)?) {
        Base.begin()
        if let completion = completion {
            Base.setCompletionBlock(completion)
        }
        excute()
        Base.commit()
    }
}
