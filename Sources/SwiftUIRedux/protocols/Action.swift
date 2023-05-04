//
//  Action.swift
//  
//
//  Created by Eazon on 2023/4/28.
//
// store更新dispatch方案的需要实现的当前协议

import Foundation

public protocol Action {
}

public extension Action {
    
    /// 返回Action的实现
    func convert<T: Action>(_: T.Type) -> T? {
        return self as? T
    }
    /// 返回Action的实现
    func convert<T: Action>() -> T? {
        return self as? T
    }
}

