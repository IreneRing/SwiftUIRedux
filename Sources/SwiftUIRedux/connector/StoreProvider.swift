//
//  StoreProvider.swift
//  
//
//  Created by Eazon on 2023/4/28.
//
// store提供者

import SwiftUI


public struct StoreProvider<StoreState: RxState, V: View>: View {
    public let store: Store<StoreState>
    public let content: () -> V
    
    public init(store: Store<StoreState>, content: @escaping () -> V) {
        self.store = store
        self.content = content
    }
    
    public var body: some View {
        // 设置环境变量
        content().environmentObject(store)
    }
}
