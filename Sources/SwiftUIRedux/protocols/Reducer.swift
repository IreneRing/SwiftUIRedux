//
//  Reducer.swift
//  
//
//  Created by Eazon on 2023/4/28.
//

import Foundation

// store的处理函数
public typealias Reducer<T: RxState> = (_ state: T, _ action: Action) -> T

