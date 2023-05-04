//
//  StoreConnector.swift
//  
//
//  Created by Eazon on 2023/4/28.
//
// store连接器

import SwiftUI

public struct StoreConnector<StoreState: RxState, V: View>: View {
    
    @EnvironmentObject var store: Store<StoreState>
    
    let content: (StoreState, @escaping (Action) -> Void) -> V
    
    
    public var body: V {
        content(store.state, store.dispatch(action:))
    }
}
