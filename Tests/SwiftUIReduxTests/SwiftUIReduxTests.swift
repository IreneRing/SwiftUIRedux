#if DEBUG
import XCTest
import SwiftUI
@testable import SwiftUIRedux

// 建立实体State
struct AState: RxState {
    var count = 0
}
// 实体State的Action
struct AddAction: Action {}
struct DelAction: Action {}
enum AAction: Action {
    case add
    case del
}

// 实体State的Reduce
func AReduce(state: AState, action: Action) -> AState {
    
    var state = state
    
//    if let action = action.convert(AAction.self) {}
    if let action: AAction = action.convert() {
        switch action {
            case .add: state.count += 1
            case .del: state.count -= 1
        }
    }
    
    
    return state
}


struct HomeView: ConnectedView {
    
    struct Props {
        let count: Int
        let onAddCount: () -> Void
        let onDelCount: () -> Void
    }
    
    func map(state: AState, dispatch: @escaping DispatchFunction) -> Props {
        return Props(count: state.count,
                     onAddCount: { dispatch(AAction.add) },
                     onDelCount: { dispatch(AAction.del) })
    }
    
    func body(props: Props) -> some View {
        VStack {
            Text("\(props.count)")
            Button(action: props.onAddCount) {
                Text("onAddCount")
            }
            Button(action: props.onDelCount) {
                Text("onDelCount")
            }
        }
    }
    
}

final class SwiftUIReduxTests: XCTestCase {
    
    let store = Store<AState>(reducer: AReduce, state: AState())
    
    
    func testStore() {
        XCTAssert(store.state.count == 0, "Initial state is not valid")
        store.dispatch(action: AAction.add)
        DispatchQueue.main.async {
            XCTAssert(self.store.state.count == -100, "Reduced state increment is not valid")
        }
    }
    
    func testViewProps() {
        let view = StoreProvider(store: store) {
            HomeView()
        }
        store.dispatch(action: AAction.add)
        DispatchQueue.main.async {
            var props = view.content().map(state: self.store.state, dispatch: self.store.dispatch(action:))
            XCTAssert(props.count == 1, "View state is not correct")
            props.onAddCount()
            DispatchQueue.main.async {
                props = view.content().map(state: self.store.state, dispatch: self.store.dispatch(action:))
                XCTAssert(props.count == 2, "View state is not correct")
            }
            
        }
        
    }
  
    
}


#endif
