//
//  AsyncActionsMiddleware.swift
//  
//
//  Created by Eazon on 2023/4/28.
//

import Foundation

// asyncAction的中间件实现
public let asyncActionsMiddleware: Middleware<RxState> = { dispatch, getState in // DispatchFunction, () -> RxState?
    return { next in // DispatchFunction
        return { action in // Action
            // 异步方案进行叠加
            if let action = action as? AsyncAction {
                action.excute(state: getState(), dispatch: dispatch)
            }
            // 向下传递DispatchFunction
            return next(action)
        }
    }
}
