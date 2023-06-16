//
//  AnyProxy.swift
//  SwiftExtensions
//
//  Created by tanxl on 2023/6/16.
//

import Foundation

/*
 @Proxy(\对象 get, set 便捷写法)
 
 class TestView: UIView {
     
     @Proxy(\.statusLabel.text)  //便完成了对`statusLabel.text`的`status`赋值
     var status: String?
     
     lazy var statusLabel: UILabel = UILabel()
 }
 
 https://gist.github.com/jegnux/4a9871220ef93016d92194ecf7ae8919
 */
@propertyWrapper
public struct AnyProxy<EnclosingSelf, Value> {
    
    private let keyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>
    
    public init(_ keyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>) {
        self.keyPath = keyPath
    }
    
    @available(*, unavailable, message: "The wrapped value must be accessed from the enclosing instance property.")
    public var wrappedValue: Value {
        get { fatalError() }
        set { fatalError() }
    }
    
    public static subscript(
        _enclosingInstance observed: EnclosingSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<EnclosingSelf, Self>
    ) -> Value {
        get {
            let storageValue = observed[keyPath: storageKeyPath]
            let value = observed[keyPath: storageValue.keyPath]
            return value
        }
        set {
            let storageValue = observed[keyPath: storageKeyPath]
            observed[keyPath: storageValue.keyPath] = newValue
        }
    }
}

extension NSObject: ProxyContainer {}

public protocol ProxyContainer {
    typealias Proxy<T> = AnyProxy<Self,T>
}
