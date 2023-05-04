//
//  AsyncAction.swift
//  
//
//  Created by Eazon on 2023/4/28.
//
// store更新dispatch异步方案的需要实现的当前协议

import Foundation

public protocol AsyncAction: Action {
    func excute(state: RxState?, dispatch: @escaping DispatchFunction)
}
