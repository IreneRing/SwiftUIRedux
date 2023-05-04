//
//  ConnectedView.swift
//  
//
//  Created by Eazon on 2023/4/28.
//
// 连接器页面

import SwiftUI

public protocol ConnectedView: View {
    /// 定义类型协议
    associatedtype StoreState: RxState
    associatedtype V: View
    /// 实现方法
    /// <------->
    associatedtype Props
    func body(props: Props) -> V
    /// 映射
    func map(state: StoreState, dispatch: @escaping DispatchFunction) -> Props
    /// <------->
}

// 扩展public方法
public extension ConnectedView {
    /// 渲染
    func render(state: StoreState, dispatch: @escaping DispatchFunction) -> V {
        let props = map(state: state, dispatch: dispatch)
        return body(props: props)
    }
    
    /// 获取store连接器
    var body: StoreConnector<StoreState, V> {
        return StoreConnector(content: render)
    }
    
}
