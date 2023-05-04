//
//  Middleware.swift
//  
//
//  Created by Eazon on 2023/4/28.
//

import Foundation

/// actino的Dispatch函数
public typealias DispatchFunction = (Action) -> Void

/// 中间件函数
public typealias Middleware<RxState> = (@escaping DispatchFunction, @escaping () -> RxState?) -> (@escaping DispatchFunction) -> DispatchFunction

