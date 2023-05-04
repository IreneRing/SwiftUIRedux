//
//  Store.swift
//  
//
//  Created by Eazon on 2023/4/28.
//
import Combine
import SwiftUI

final public class Store<StoreState: RxState>: ObservableObject {
    @Published public var state: StoreState
    
    // Variable 'self.dispatchFunction' used before being initialized
    private var dispatchFunction: DispatchFunction!
    private let reducer: Reducer<StoreState>
    
    public init(reducer: @escaping Reducer<StoreState>,
                middleware: [Middleware<StoreState>] = [],
                state: StoreState) {
        self.state = state
        self.reducer = reducer
        
        // 追加异步action中间件
        var middleware = middleware
        middleware.append(asyncActionsMiddleware)
        
        self.dispatchFunction = middleware
            .reversed() // 倒序
            // 计算
            .reduce( // 初始值Void类型； 叠加值Void类型，当前值Middleware -> Void
                // action 被函数逆推了类型
                { [unowned self] action in self._dispatch(action: action) },
                // { [weak self] in self?._dispatch(action: $0) },
                { dispatchFunction, middleware in
                    // self => Store()
                    let dispatch: (Action) -> Void = { [weak self] in self?.dispatch(action: $0) }
                    let getState = { [weak self] in self?.state }
                    return middleware(dispatch, getState)(dispatchFunction)
                })
    }
    
    public func dispatch(action: Action) {
        // main线程异步
        DispatchQueue.main.async {
            self.dispatchFunction(action)
        }
    }
    
    private func _dispatch(action: Action) {
        state = reducer(state, action)
    }

}

